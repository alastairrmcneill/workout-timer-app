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
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${workout.name}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Activities: ${workout.activityCount}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'Time: ${workout.activityTime}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
