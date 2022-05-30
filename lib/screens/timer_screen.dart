import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/services/services.dart';
import 'package:workout_timer_app/widgets/workout_bottom_sheet.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late MultiStageTimer multiStageTimer;
  List<int> stages = [10];
  @override
  void initState() {
    super.initState();
    ActivityNotifier activityNotifiter = Provider.of<ActivityNotifier>(context, listen: false);
    TimerNotifier timerNotifier = Provider.of<TimerNotifier>(context, listen: false);

    for (Activity activity in activityNotifiter.activityList!) {
      stages.add(activity.time);
    }

    multiStageTimer = MultiStageTimer(timerNotifier: timerNotifier, stages: stages, currentIndex: 0);
  }

  @override
  void dispose() {
    multiStageTimer.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ActivityNotifier activityNotifiter = Provider.of<ActivityNotifier>(context);
    TimerNotifier timerNotifier = Provider.of<TimerNotifier>(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: timerNotifier.totalTimeRemaining == null ? Text('Remaining: ${multiStageTimer.totalTime}') : Text('Remaining: ${timerNotifier.totalTimeRemaining!}'),
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
                    child: timerNotifier.stageTimeRemaining == null ? const Text('10') : Text('${timerNotifier.stageTimeRemaining}'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          child: timerNotifier.isRunning == null
                              ? Text('Play')
                              : timerNotifier.isRunning!
                                  ? Text('Pause')
                                  : Text('Play'),
                          onPressed: () {
                            if (timerNotifier.isRunning == null) {
                              multiStageTimer.start();
                            } else {
                              if (timerNotifier.isRunning!) {
                                multiStageTimer.cancel();
                              } else {
                                multiStageTimer.start();
                              }
                            }
                            ;
                          },
                        ),
                      ),
                      const SizedBox(width: 30),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          child: Text('End'),
                          onPressed: () {
                            multiStageTimer.cancel();

                            Navigator.pop(context);
                          },
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
