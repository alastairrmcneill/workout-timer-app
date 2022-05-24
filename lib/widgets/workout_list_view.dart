import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';
import 'package:workout_timer_app/widgets/widgets.dart';

class WorkoutListView extends StatelessWidget {
  const WorkoutListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkoutNotifier workoutNotifier = Provider.of<WorkoutNotifier>(context);
    return workoutNotifier.workoutList != null
        ? workoutNotifier.workoutList!.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: workoutNotifier.workoutList!.map((workout) {
                    return WorkoutTile(workout: workout);
                  }).toList(),
                ),
              )
            : const Center(
                child: Text("Get started by clicking the + to add a workout"),
              )
        : const Center(
            child: Text('No workouts'),
          );
  }
}
