import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_timer_app/app.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({Key? key, required this.prefs}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkoutNotifier>(
          create: (_) => WorkoutNotifier(),
        ),
        ChangeNotifierProvider<ActivityNotifier>(
          create: (_) => ActivityNotifier(),
        ),
        ChangeNotifierProvider<SettingsNotifier>(
          create: (_) => SettingsNotifier(
            darkMode: prefs.getBool('darkMode') ?? false,
            audioMode: prefs.getBool('audioMode') ?? false,
          ),
        ),
        ChangeNotifierProvider<TimerNotifier>(
          create: (_) => TimerNotifier(),
        )
      ],
      child: const App(),
    );
  }
}
