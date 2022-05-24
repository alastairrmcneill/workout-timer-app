import 'package:workout_timer_app/models/models.dart';

final String tableWorkouts = 'workouts';

class WorkoutFields {
  static final List<String> values = [id, name, activityCount];

  static final String id = '_id';
  static final String name = 'name';
  static final String activityCount = 'activityCount';
}

class Workout {
  final int? id;
  final String name;
  final int activityCount;

  Workout({
    this.id,
    required this.name,
    required this.activityCount,
  });

  static Workout fromJSON(json) {
    return Workout(
      id: json[WorkoutFields.id] as int?,
      name: json[WorkoutFields.name] as String,
      activityCount: json[WorkoutFields.activityCount] as int,
    );
  }

  // To JSON
  Map<String, Object?> toJSON() {
    return {
      WorkoutFields.id: id,
      WorkoutFields.name: name,
      WorkoutFields.activityCount: activityCount,
    };
  }

  Workout copy({
    int? id,
    String? name,
    int? activityCount,
  }) =>
      Workout(
        id: id ?? this.id,
        name: name ?? this.name,
        activityCount: activityCount ?? this.activityCount,
      );
}
