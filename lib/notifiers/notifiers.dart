import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_timer_app/models/models.dart';

class WorkoutNotifier extends ChangeNotifier {
  List<Workout>? _workoutList;
  Workout? _currentWorkout;

  List<Workout>? get workoutList => _workoutList;
  Workout? get currentWorkout => _currentWorkout;

  set setWorkoutList(List<Workout> workoutList) {
    _workoutList = workoutList;
    notifyListeners();
  }

  set setCurrentWorkout(Workout currentWorkout) {
    _currentWorkout = currentWorkout;
    notifyListeners();
  }
}

class ActivityNotifier extends ChangeNotifier {
  List<Activity>? _activityList;
  Activity? _currentActivity;

  List<Activity>? get activityList => _activityList;
  Activity? get currentWorkout => _currentActivity;

  set setActivityList(List<Activity> activityList) {
    _activityList = activityList;
    notifyListeners();
  }

  set setCurrentActivity(Activity currentActivity) {
    _currentActivity = currentActivity;
    notifyListeners();
  }
}

class TimerNotifier extends ChangeNotifier {
  int? _stageTimeRemaining;
  int? _totalTimeRemaining;
  int? _currentStageIndex;
  bool? _isRunning;

  int? get stageTimeRemaining => _stageTimeRemaining;
  int? get totalTimeRemaining => _totalTimeRemaining;
  int? get currentStageIndex => _currentStageIndex;
  bool? get isRunning => _isRunning;

  set setStageTimeRemaining(int timeRemaining) {
    _stageTimeRemaining = timeRemaining;
    notifyListeners();
  }

  set setTotalTimeRemaining(int timeRemaining) {
    _totalTimeRemaining = timeRemaining;
    notifyListeners();
  }

  set setCurrentStageIndex(int currentStageIndex) {
    _currentStageIndex = currentStageIndex;
    notifyListeners();
  }

  set setIsRunning(bool isRunnning) {
    //not working
    _isRunning = isRunning;
    notifyListeners();
  }

  resetAll() {
    _stageTimeRemaining = null;
    _totalTimeRemaining = null;
    _currentStageIndex = null;
    _isRunning = null;
  }
}

class SettingsNotifier extends ChangeNotifier {
  late SharedPreferences prefs;
  late bool _darkMode;
  late bool _audioMode;

  SettingsNotifier({required bool darkMode, required bool audioMode}) {
    _darkMode = darkMode;
    _audioMode = audioMode;
  }

  bool get darkMode => _darkMode;
  bool get audioMode => _audioMode;

  Future<void> setDarkMode(bool darkMode) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', darkMode);
    _darkMode = darkMode;
    notifyListeners();
  }

  Future<void> setAudioMode(bool audioMode) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool('audioMode', audioMode);
    _audioMode = audioMode;
    notifyListeners();
  }
}
