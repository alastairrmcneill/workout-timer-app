import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';
import 'package:workout_timer_app/services/database_service.dart';
import 'package:workout_timer_app/widgets/workout_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _workoutName;

  @override
  void initState() {
    super.initState();
    WorkoutNotifier workoutNotifier = Provider.of<WorkoutNotifier>(context, listen: false);

    WorkoutDatabase.instance.readAllWorkouts(workoutNotifier);
  }

  void createWorkout(WorkoutNotifier workoutNotifier) async {
    Workout newWorkout = Workout(
      name: _workoutName,
      activityCount: 0,
    );

    await WorkoutDatabase.instance.create(workoutNotifier, newWorkout);
    Navigator.of(context).pop();
    await WorkoutDatabase.instance.readAllWorkouts(workoutNotifier);
  }

  Future openDialog(WorkoutNotifier workoutNotifier) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Workout Name'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              autofocus: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Required';
                }
                return null;
              },
              onSaved: (value) {
                _workoutName = value!;
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CREATE'),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                _formKey.currentState!.save();
                createWorkout(workoutNotifier);
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    WorkoutNotifier workoutNotifier = Provider.of<WorkoutNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Timer"),
        actions: [
          IconButton(
            onPressed: () {
              openDialog(workoutNotifier);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const WorkoutListView(),
    );
  }
}
