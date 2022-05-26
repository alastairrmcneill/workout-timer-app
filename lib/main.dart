import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/app.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';

import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkoutNotifier>(
          create: (_) => WorkoutNotifier(),
        ),
        ChangeNotifierProvider<ActivityNotifiter>(
          create: (_) => ActivityNotifiter(),
        ),
        ChangeNotifierProvider<SettingsNotifier>(
          create: (_) => SettingsNotifier(),
        )
      ],
      child: const App(),
    );
  }
}
