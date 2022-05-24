import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';
import 'package:workout_timer_app/services/database_service.dart';

class ActivityTile extends StatelessWidget {
  final Activity activity;
  const ActivityTile({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkoutNotifier workoutNotifier = Provider.of<WorkoutNotifier>(context);
    ActivityNotifiter activityNotifiter = Provider.of<ActivityNotifiter>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: ValueKey(activity),
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          color: Colors.red,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        onDismissed: (direction) async {
          ActivityDatabase.instance.deleteActivity(workoutNotifier, activityNotifiter, activity);
        },
        direction: DismissDirection.endToStart,
        child: Container(
          width: double.infinity,
          height: 100,
          color: Colors.green,
          child: Column(
            children: [
              Text(activity.name),
              Text(activity.time.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
