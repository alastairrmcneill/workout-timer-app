import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: (settingsNotifier.darkMode == null) ? false : settingsNotifier.darkMode!,
              onChanged: (value) {
                setState(() {
                  settingsNotifier.setDarkMode = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Play audio'),
            subtitle: const Text('Play 3 beeps to signal end of activity'),
            trailing: Switch(
                value: (settingsNotifier.audioMode == null) ? true : settingsNotifier.audioMode!,
                onChanged: (value) {
                  setState(() {
                    settingsNotifier.setAudioMode = value;
                  });
                }),
          ),
        ],
      ),
    );
  }
}
