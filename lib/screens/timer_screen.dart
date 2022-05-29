import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/widgets/workout_bottom_sheet.dart';

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
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: Text('Remaining: 00:22'),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2 - 250,
                  ),
                  Container(
                    height: 250,
                    width: 250,
                    color: Colors.red,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          child: Text('Skip'),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 30),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          child: Text('Go Back'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            WorkoutBottomSheet(),
          ],
        ),
      ),
    );
  }
}
