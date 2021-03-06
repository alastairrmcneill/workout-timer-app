import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';

class MultiStageTimer {
  final TimerNotifier timerNotifier;
  final SettingsNotifier settingsNotifier;
  final List<int> stages;
  late int currentIndex;
  late Timer timer = Timer(Duration(seconds: 1), (() {}));
  late int currentStage;
  late int totalTime;
  bool isRunning = false;
  bool isFinished = false;

  MultiStageTimer({required this.timerNotifier, required this.settingsNotifier, required this.stages, required this.currentIndex}) {
    currentStage = stages[currentIndex];
    totalTime = stages.sum;
  }

  // Start timer
  start() {
    isRunning = true;
    timerNotifier.setCurrentStageIndex = currentIndex;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentStage > 0) {
        currentStage--;
        if (currentStage <= 3) {
          if (settingsNotifier.audioMode) {
            FlutterBeep.beep();
          }
        }
      } else {
        if (currentIndex < stages.length - 1) {
          currentIndex++;
          _skipToStage(currentIndex);
        } else {
          isFinished = true;
          cancel();
        }
      }

      timerNotifier.setStageTimeRemaining = currentStage;
      timerNotifier.setTotalTimeRemaining = _timeRemaining();
    });
  }

  // Pause timer
  pause() {
    isRunning = false;
    timer.cancel();
  }

  // Cancel timer
  cancel() {
    timer.cancel();
    isRunning = false;
  }

  // Skip one stage
  skipToStage(int stageIndex) {
    pause();
    currentIndex = stageIndex;
    currentStage = stages[currentIndex];
    timerNotifier.setCurrentStageIndex = currentIndex;
    timerNotifier.setStageTimeRemaining = currentStage;
    timerNotifier.setTotalTimeRemaining = _timeRemaining();
  }

  //Skip to specific stage
  _skipToStage(int stageIndex) {
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
    isRunning = false;
    isFinished = false;
    currentIndex = 0;
    currentStage = stages[currentIndex];
    timer.cancel();

    timerNotifier.resetAll();
  }
}
