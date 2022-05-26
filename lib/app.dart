import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/support/themes.dart';

import 'notifiers/notifiers.dart';
import 'screens/screens.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    // Read from shared preferences to update settings
  }

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workout Timer',
      theme: (settingsNotifier.darkMode == null)
          ? MyThemes.getLightTheme()
          : (settingsNotifier.darkMode!)
              ? MyThemes.getDarkTheme()
              : MyThemes.getLightTheme(),
      home: const HomeScreen(),
    );
  }
}
