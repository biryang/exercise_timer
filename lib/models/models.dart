import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var player = AudioCache();

Exercise get defaultExercise => Exercise(
  setTimer: Duration(seconds: 10)
);

class Settings {
  final SharedPreferences _prefs;

  bool nightMode;
  bool silentMode;
  Color primarySwatch;
  String countdownPip;
  String startRep;
  String startRest;
  String startBreak;
  String startSet;
  String endWorkout;

  Settings(this._prefs) {
    Map<String, dynamic> json =
    jsonDecode(_prefs.getString('settings') ?? '{}');
    nightMode = json['nightMode'] ?? false;
    silentMode = json['silentMode'] ?? false;
    primarySwatch = Colors.primaries[
    json['primarySwatch'] ?? Colors.primaries.indexOf(Colors.deepPurple)];
    countdownPip = json['countdownPip'] ?? 'pip.mp3';
    startRep = json['startRep'] ?? 'boop.mp3';
    startRest = json['startRest'] ?? 'boop.mp3';
    startBreak = json['startBreak'] ?? 'boop.mp3';
    startSet = json['startSet'] ?? 'boop.mp3';
    endWorkout = json['endWorkout'] ?? 'boop.mp3';
  }

  save() {
    _prefs.setString('settings', jsonEncode(this));
  }

  Map<String, dynamic> toJson() => {
    'nightMode': nightMode,
    'silentMode': silentMode,
    'primarySwatch': Colors.primaries.indexOf(primarySwatch),
    'countdownPip': countdownPip,
    'startRep': startRep,
    'startRest': startRest,
    'startBreak': startBreak,
    'startSet': startSet,
    'endWorkout': endWorkout,
  };
}

class Exercise {
  Duration setTimer;
  Exercise({
    this.setTimer,
  });

  Exercise.fromJson(Map<String, dynamic> json)
      : setTimer = Duration(seconds: json['setTimer']);

  Map<String, dynamic> toJson() => {
    'setTimer': setTimer,
  };
}

enum WorkoutState { initial, starting, exercising, resting, breaking, finished }

class Workout {
  Settings _settings;

  Exercise _config;

  /// Callback for when the workout's state has changed.
  Function _onStateChange;

  WorkoutState _step = WorkoutState.initial;

  Timer _timer;

  /// Time left in the current step
  Duration _timeLeft;

  Duration _totalTime = Duration(seconds: 0);

  /// Current set
  int _set = 0;

  /// Current rep
  int _rep = 0;

  Workout(this._settings, this._config, this._onStateChange);

  /// Starts or resumes the workout
  start() {
    if (_step == WorkoutState.initial) {
      _step = WorkoutState.starting;
      if (_config.setTimer.inSeconds == 0) {
        _nextStep();
      } else {
        _timeLeft = _config.setTimer;
      }
    }
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
    _onStateChange();
  }

  /// Pauses the workout
  pause() {
    _timer.cancel();
    _onStateChange();
  }

  /// Stops the timer without triggering the state change callback.
  dispose() {
    _timer.cancel();
  }

  _tick(Timer timer) {
    if (_step != WorkoutState.starting) {
      _totalTime += Duration(seconds: 1);
    }

    if (_timeLeft.inSeconds == 1) {
      _nextStep();
    } else {
      _timeLeft -= Duration(seconds: 1);
      if (_timeLeft.inSeconds <= 3 && _timeLeft.inSeconds >= 1) {
        _playSound(_settings.countdownPip);
      }
    }

    _onStateChange();
  }

  /// Moves the workout to the next step and sets up state for it.
  _nextStep() {
  }

  Future _playSound(String sound) {
    if (_settings.silentMode) {
      return Future.value();
    }
    return player.play(sound);
  }

  get config => _config;

  get timeLeft => _timeLeft;

  get totalTime => _totalTime;

  get isActive => _timer != null && _timer.isActive;
}