import 'dart:async';
import 'dart:ffi';
import 'package:collection/collection.dart';

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

  String buildTime(int value) {
    int h, m, s;
    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();

    String minuteLeft = m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft = s.toString().length < 2 ? "0" + s.toString() : s.toString();

    String result = "$minuteLeft:$secondsLeft";

    return result;
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
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headline6,
                  children: [
                    TextSpan(text: 'Remaining: '),
                    TextSpan(
                      text: buildTime(timerNotifier.totalTimeRemaining ?? multiStageTimer.stages.sum),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2 - 250,
                    child: Center(
                        child: Text(
                      '\nHere',
                      style: Theme.of(context).textTheme.headline4,
                    )),
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
                          child: Text(
                            '${buildTime(timerNotifier.stageTimeRemaining ?? 10)}',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
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
                      const SizedBox(width: 30),
                      OutlinedButton(
                        child: Text('End'),
                        onPressed: () {
                          multiStageTimer.reset();

                          Navigator.pop(context);
                        },
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
