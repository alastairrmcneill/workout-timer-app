import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';
import 'package:workout_timer_app/screens/screens.dart';
import 'package:workout_timer_app/services/database_service.dart';
import 'package:workout_timer_app/widgets/workout_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _workoutName;

  @override
  void initState() {
    super.initState();
    WorkoutNotifier workoutNotifier = Provider.of<WorkoutNotifier>(context, listen: false);
    WorkoutDatabase.instance.readAllWorkouts(workoutNotifier);
  }

  void createWorkout(WorkoutNotifier workoutNotifier) async {
    Workout newWorkout = Workout(
      name: _workoutName,
      activityCount: 0,
      activityTime: 0,
    );

    await WorkoutDatabase.instance.create(workoutNotifier, newWorkout);
    Navigator.pop(context);
    await WorkoutDatabase.instance.readAllWorkouts(workoutNotifier);
  }

  Future openDialog(WorkoutNotifier workoutNotifier) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Workout Name',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              autofocus: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Required';
                }
                return null;
              },
              onSaved: (value) {
                _workoutName = value!;
              },
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
                createWorkout(workoutNotifier);
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    WorkoutNotifier workoutNotifier = Provider.of<WorkoutNotifier>(context);
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Timer'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen())),
          icon: const Icon(Icons.settings_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              openDialog(workoutNotifier);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Theme.of(context).backgroundColor],
                  stops: [0.85, 0.95],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: WorkoutListView(),
            ),
          )
        ],
      ),
    );
  }
}
