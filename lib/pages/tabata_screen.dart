import 'dart:convert';

import 'package:exercise_timer/pages/workout.dart';
import 'package:exercise_timer/widgets/durationpicker.dart';
import 'package:exercise_timer/widgets/numberpicker.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models.dart';
import '../utils.dart';

class TabataScreen extends StatefulWidget {
  final Settings settings;
  final SharedPreferences prefs;
  final Function onSettingsChanged;

  TabataScreen({
    @required this.settings,
    @required this.prefs,
    @required this.onSettingsChanged,
  });

  @override
  State<StatefulWidget> createState() => _TabataScreenState();
}

class _TabataScreenState extends State<TabataScreen> {
  Tabata _tabata;

  @override
  initState() {
    var json = widget.prefs.getString('tabata');
    _tabata = json != null ? Tabata.fromJson(jsonDecode(json)) : defaultTabata;
    super.initState();
  }

  _onTabataChanged() {
    setState(() {});
    _saveTabata();
  }

  _saveTabata() {
    widget.prefs.setString('tabata', jsonEncode(_tabata.toJson()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabata Timer'),
        leading: Icon(Icons.timer),
        actions: <Widget>[
          Builder(
            builder: (context) =>
                IconButton(
                  icon: Icon(widget.settings.silentMode
                      ? Icons.volume_off
                      : Icons.volume_up),
                  onPressed: () {
                    widget.settings.silentMode = !widget.settings.silentMode;
                    widget.onSettingsChanged();
                    var snackBar = SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                            'Silent mode ${!widget.settings.silentMode
                                ? 'de'
                                : ''}activated'));
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  tooltip: 'Toggle silent mode',
                ),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SettingsScreen(
              //         settings: widget.settings,
              //         onSettingsChanged: widget.onSettingsChanged),
              //   ),
              // );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Sets'),
            subtitle: Text('${_tabata.sets}'),
            leading: Icon(Icons.fitness_center),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NumberPickerDialog(
                    initialNumber: _tabata.sets,
                    title: Text('Excercise time per repetition'),
                  );
                },
              ).then((sets) {
                if (sets == null) return;
                _tabata.sets = sets;
                _onTabataChanged();
              });
            },
          ),
          ListTile(
            title: Text('Reps'),
            subtitle: Text('${_tabata.reps}'),
            leading: Icon(Icons.repeat),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NumberPickerDialog(
                    initialNumber: _tabata.reps,
                    title: Text('Excercise time per repetition'),
                  );
                },
              ).then((reps) {
                if (reps == null) return;
                _tabata.reps = reps;
                _onTabataChanged();
              });
            },
          ),
          Divider(
            height: 10,
          ),
          ListTile(
            title: Text('Starting Countdown'),
            subtitle: Text(formatTime(_tabata.startDelay)),
            leading: Icon(Icons.timer),
            onTap: () {
              showDialog<Duration>(
                context: context,
                builder: (BuildContext context) {
                  return DurationPickerDialog(
                    initialDuration: _tabata.startDelay,
                    title: Text('Countdown before starting workout'),
                  );
                },
              ).then((startDelay) {
                if (startDelay == null) return;
                _tabata.startDelay = startDelay;
                _onTabataChanged();
              });
            },
          ),
          ListTile(
            title: Text('Exercise Time'),
            subtitle: Text(formatTime(_tabata.exerciseTime)),
            leading: Icon(Icons.timer),
            onTap: () {
              showDialog<Duration>(
                context: context,
                builder: (BuildContext context) {
                  return DurationPickerDialog(
                    initialDuration: _tabata.exerciseTime,
                    title: Text('Excercise time per repetition'),
                  );
                },
              ).then((exerciseTime) {
                if (exerciseTime == null) return;
                _tabata.exerciseTime = exerciseTime;
                _onTabataChanged();
              });
            },
          ),
          ListTile(
            title: Text('Rest Time'),
            subtitle: Text(formatTime(_tabata.restTime)),
            leading: Icon(Icons.timer),
            onTap: () {
              showDialog<Duration>(
                context: context,
                builder: (BuildContext context) {
                  return DurationPickerDialog(
                    initialDuration: _tabata.restTime,
                    title: Text('Rest time between repetitions'),
                  );
                },
              ).then((restTime) {
                if (restTime == null) return;
                _tabata.restTime = restTime;
                _onTabataChanged();
              });
            },
          ),
          ListTile(
            title: Text('Break Time'),
            subtitle: Text(formatTime(_tabata.breakTime)),
            leading: Icon(Icons.timer),
            onTap: () {
              showDialog<Duration>(
                context: context,
                builder: (BuildContext context) {
                  return DurationPickerDialog(
                    initialDuration: _tabata.breakTime,
                    title: Text('Break time between sets'),
                  );
                },
              ).then((breakTime) {
                if (breakTime == null) return;
                _tabata.breakTime = breakTime;
                _onTabataChanged();
              });
            },
          ),
          Divider(height: 10),
          ListTile(
            title: Text(
              'Total Time',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(formatTime(_tabata.getTotalTime())),
            leading: Icon(Icons.timelapse),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WorkoutScreen(
                          settings: widget.settings, tabata: _tabata)));
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
