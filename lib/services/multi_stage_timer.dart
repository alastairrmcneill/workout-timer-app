import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';

class MultiStageTimer {
  final TimerNotifier timerNotifier;
  final List<int> stages;
  late int currentIndex;
  late Timer timer = Timer(Duration(seconds: 1), (() {}));
  late int currentStage;
  late int totalTime;

  MultiStageTimer({required this.timerNotifier, required this.stages, required this.currentIndex}) {
    currentStage = stages[currentIndex];
    totalTime = stages.sum;
  }

  // Start timer
  start() {
    timerNotifier.setIsRunning = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentStage > 0) {
        currentStage--;
      } else {
        if (currentIndex < stages.length - 1) {
          currentIndex++;
          skipToStage(currentIndex);
        } else {
          cancel();
        }
      }

      timerNotifier.setStageTimeRemaining = currentStage;
      timerNotifier.setTotalTimeRemaining = _timeRemaining();
    });
  }

  // Pause timer
  pause() {}

  // Cancel timer
  cancel() {
    timer.cancel();

    timerNotifier.setIsRunning = false;
  }

  // Skip one stage
  skipStage() {}

  //Skip to specific stage
  skipToStage(int stageIndex) {
    currentIndex = stageIndex;
    currentStage = stages[currentIndex];
    timerNotifier.setCurrentStageIndex = currentIndex;
  }

  int _timeRemaining() {
    int timeRemaining = 0;

    if (currentIndex < stages.length - 1) {
      List<int> remainingStages = stages.sublist(currentIndex + 1, stages.length);
      timeRemaining += remainingStages.sum;
    }

    timeRemaining += currentStage;

    return timeRemaining;
  }

  reset() {
    currentIndex = 0;
    currentStage = stages[currentIndex];

    timerNotifier.resetAll();
  }
}
