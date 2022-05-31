import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';
import 'package:workout_timer_app/widgets/widgets.dart';

class ActivityListView extends StatelessWidget {
  const ActivityListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActivityNotifier activityNotifiter = Provider.of<ActivityNotifier>(context);
    return activityNotifiter.activityList != null
        ? activityNotifiter.activityList!.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: activityNotifiter.activityList!.map((activity) {
                    return ActivityTile(activity: activity);
                  }).toList(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Get started by clicking the + to add an activity",
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
        : Center(
            child: Text(
              'No Activities',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          );
  }
}
