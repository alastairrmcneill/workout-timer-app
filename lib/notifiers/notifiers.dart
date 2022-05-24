import 'package:flutter/material.dart';
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

class ActivityNotifiter extends ChangeNotifier {
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
