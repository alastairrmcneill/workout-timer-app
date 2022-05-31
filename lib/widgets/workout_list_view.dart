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
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Get started by clicking the + to add a workout",
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
        : Center(
            child: Text(
              'No workouts',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          );
  }
}
