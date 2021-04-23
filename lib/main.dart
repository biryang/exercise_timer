import 'package:exercise_timer/models.dart';
import 'package:exercise_timer/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  runApp(TimerApp(settings: Settings(prefs), prefs: prefs));
}

class TimerApp extends StatefulWidget {
  final Settings settings;
  final SharedPreferences prefs;

  TimerApp({this.settings, this.prefs});

  @override
  State<StatefulWidget> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  _onSettingsChanged() {
    setState(() {});
    widget.settings.save();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainScreen());
  }
}
