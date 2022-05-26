import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    ActivityNotifiter activityNotifiter = Provider.of<ActivityNotifiter>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ...activityNotifiter.activityList!.map((activity) {
                return Text(activity.time.toString());
              }).toList(),
              ElevatedButton(
                child: Text('Go Back'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
