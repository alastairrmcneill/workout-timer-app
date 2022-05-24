import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';
import 'package:workout_timer_app/services/database_service.dart';
import 'package:workout_timer_app/widgets/widgets.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _activityName;
  Duration _activityDuration = Duration(seconds: 30);

  @override
  void initState() {
    super.initState();
    WorkoutNotifier workoutNotifier = Provider.of<WorkoutNotifier>(context, listen: false);
    ActivityNotifiter activityNotifiter = Provider.of<ActivityNotifiter>(context, listen: false);

    // read all activities for this workout
    ActivityDatabase.instance.readAllActivitiesFromWorkout(activityNotifiter, workoutNotifier.currentWorkout!.id!);
  }

  void createActivity(WorkoutNotifier workoutNotifier, ActivityNotifiter activityNotifiter) async {
    Activity newActivity = Activity(
      workoutId: workoutNotifier.currentWorkout!.id!,
      name: _activityName,
      time: _activityDuration.inSeconds,
    );
    await ActivityDatabase.instance.createActivity(workoutNotifier, activityNotifiter, newActivity);
    Navigator.pop(context);
    await ActivityDatabase.instance.readAllActivitiesFromWorkout(activityNotifiter, workoutNotifier.currentWorkout!.id!);
  }

  Future openDialog(WorkoutNotifier workoutNotifier, ActivityNotifiter activityNotifiter) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Activity Name'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _activityName = value!;
                    },
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: CupertinoTimerPicker(
                      initialTimerDuration: _activityDuration,
                      mode: CupertinoTimerPickerMode.ms,
                      onTimerDurationChanged: (duration) {
                        setState(() {
                          this._activityDuration = duration;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('CREATE'),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  createActivity(workoutNotifier, activityNotifiter);
                },
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    WorkoutNotifier workoutNotifier = Provider.of<WorkoutNotifier>(context);
    ActivityNotifiter activityNotifiter = Provider.of<ActivityNotifiter>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(workoutNotifier.currentWorkout!.name),
        actions: [
          IconButton(
            onPressed: () {
              openDialog(workoutNotifier, activityNotifiter);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ActivityListView(),
    );
  }
}
