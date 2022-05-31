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
              child: timerNotifier.totalTimeRemaining == null
                  ? Text(
                      'Remaining: ${multiStageTimer.totalTime}s',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  : Text(
                      'Remaining: ${timerNotifier.totalTimeRemaining!}s',
                      style: Theme.of(context).textTheme.headline6,
                    ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2 - 250,
                  ),
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: (timerNotifier.stageTimeRemaining == null || timerNotifier.currentStageIndex == null)
                              ? 1
                              : timerNotifier.stageTimeRemaining! / multiStageTimer.stages[timerNotifier.currentStageIndex!],
                          strokeWidth: 6,
                          backgroundColor: Theme.of(context).highlightColor,
                        ),
                        Center(
                          child: timerNotifier.stageTimeRemaining == null
                              ? Text('10', style: Theme.of(context).textTheme.headline3)
                              : Text('${timerNotifier.stageTimeRemaining}', style: Theme.of(context).textTheme.headline3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          child: !multiStageTimer.isRunning ? Text('Play') : Text('Pause'),
                          onPressed: () {
                            if (!multiStageTimer.isRunning) {
                              multiStageTimer.start();
                            } else {
                              multiStageTimer.pause();
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 30),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          child: Text('End'),
                          onPressed: () {
                            multiStageTimer.reset();

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
