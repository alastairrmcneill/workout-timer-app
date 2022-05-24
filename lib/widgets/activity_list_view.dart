import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';
import 'package:workout_timer_app/widgets/widgets.dart';

class ActivityListView extends StatelessWidget {
  const ActivityListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActivityNotifiter activityNotifiter = Provider.of<ActivityNotifiter>(context);
    return activityNotifiter.activityList != null
        ? activityNotifiter.activityList!.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: activityNotifiter.activityList!.map((activity) {
                    return ActivityTile(activity: activity);
                  }).toList(),
                ),
              )
            : const Center(
                child: Text("Get started by clicking the + to add an activity"),
              )
        : const Center(
            child: Text('No Activities'),
          );
  }
}
