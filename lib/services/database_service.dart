import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workout_timer_app/models/activity_model.dart';
import 'package:workout_timer_app/models/workout_model.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';

class WorkoutDatabase {
  static final WorkoutDatabase instance = WorkoutDatabase._init();
  static Database? _database;

  WorkoutDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('workout.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute("CREATE TABLE $tableWorkouts (${WorkoutFields.id} ${idType}, ${WorkoutFields.name} ${textType}, ${WorkoutFields.activityCount} ${integerType})");
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  // Create
  Future create(WorkoutNotifier workoutNotifier, Workout workout) async {
    final db = await instance.database;
    final uid = await db.insert(tableWorkouts, workout.toJSON());
    readAllWorkouts(workoutNotifier);
  }

  // Read

  Future readAllWorkouts(WorkoutNotifier workoutNotifier) async {
    final db = await instance.database;

    final result = await db.query(tableWorkouts);

    List<Workout> _workoutList = result.map((json) => Workout.fromJSON(json)).toList();

    workoutNotifier.setWorkoutList = _workoutList;
  }

  // Update
  Future updateWorkoutActivityCount(WorkoutNotifier workoutNotifier, int updateAmount) async {
    final db = await instance.database;
    Workout oldWorkout = workoutNotifier.currentWorkout!;

    Workout newWorkout = oldWorkout.copy(activityCount: oldWorkout.activityCount + updateAmount);

    await db.update(
      tableWorkouts,
      newWorkout.toJSON(),
      where: '${WorkoutFields.id} = ?',
      whereArgs: [newWorkout.id],
    );

    readAllWorkouts(workoutNotifier);
  }

  // Delete
  Future delete(WorkoutNotifier workoutNotifier, int id) async {
    final db = await instance.database;

    await db.delete(
      tableWorkouts,
      where: '${WorkoutFields.id} = ?',
      whereArgs: [id],
    );

    readAllWorkouts(workoutNotifier);
  }
}

class ActivityDatabase {
  static final ActivityDatabase instance = ActivityDatabase._init();
  static Database? _database;

  ActivityDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('activity.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute(
        "CREATE TABLE ${tableActivites} (${ActivityFields.id} ${idType}, ${ActivityFields.workoutId} ${integerType}, ${ActivityFields.name} ${textType}, ${ActivityFields.time} ${integerType})");
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  // Create
  Future createActivity(WorkoutNotifier workoutNotifier, ActivityNotifiter activityNotifiter, Activity activity) async {
    final db = await instance.database;
    final id = await db.insert(tableActivites, activity.toJSON());

    await WorkoutDatabase.instance.updateWorkoutActivityCount(workoutNotifier, 1);
    readAllActivitiesFromWorkout(activityNotifiter, activity.workoutId);
  }

  // Read

  Future readAllActivitiesFromWorkout(ActivityNotifiter activityNotifiter, int workoutId) async {
    final db = await instance.database;

    final result = await db.query(
      tableActivites,
      columns: ActivityFields.values,
      where: '${ActivityFields.workoutId} = ?',
      whereArgs: [workoutId],
    );

    List<Activity> activityList = [];
    if (result.isNotEmpty) {
      activityList = result.map((json) => Activity.fromJSON(json)).toList();
    }

    activityNotifiter.setActivityList = activityList;
  }

  // Update

  // Delete
  Future deleteActivity(WorkoutNotifier workoutNotifier, ActivityNotifiter activityNotifiter, int id) async {
    final db = await instance.database;

    await db.delete(
      tableActivites,
      where: '${ActivityFields.id} = ?',
      whereArgs: [id],
    );

    WorkoutDatabase.instance.updateWorkoutActivityCount(workoutNotifier, -1);
    readAllActivitiesFromWorkout(activityNotifiter, workoutNotifier.currentWorkout!.id!);
  }
}
