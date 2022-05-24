import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';
import 'package:workout_timer_app/screens/screens.dart';
import 'package:workout_timer_app/services/database_service.dart';

class WorkoutTile extends StatelessWidget {
  final Workout workout;
  const WorkoutTile({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkoutNotifier workoutNotifier = Provider.of<WorkoutNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          workoutNotifier.setCurrentWorkout = workout;
          Navigator.push(context, MaterialPageRoute(builder: (_) => WorkoutScreen()));
        },
        child: Dismissible(
          key: ValueKey(workout),
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) async {
            WorkoutDatabase.instance.delete(workoutNotifier, workout.id!);
          },
          direction: DismissDirection.endToStart,
          child: Container(
            width: double.infinity,
            height: 100,
            color: Colors.blue,
            child: Column(
              children: [
                Text(workout.name),
                Text(workout.activityCount.toString()),
                Text(workout.activityTime.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
