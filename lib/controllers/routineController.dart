import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:exercise_timer/models/routine_model.dart';
import 'package:exercise_timer/models/timer_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class RoutineController extends GetxController {
  List routines = [];
  List<TimerModel> timerList = [];
  List<Duration> timeList = [];
  List<Duration> activeList = [];
  int _playTime = 0;
  Timer _timer;
  AudioCache player = AudioCache();

  addRoutine(String routineTitle) async {
    var box = await Hive.openBox<RoutineModel>('routines');
    box.add(
      RoutineModel(
        title: routineTitle,
        index: 1,
      ),
    );
    routines.add(routineTitle);
    update();
    print('routine $routineTitle add');
  }

  readRoutine() async {
    var box = await Hive.openBox<RoutineModel>('routines');
    List readRoutines = [];
    for (int index = 0; index < box.length; index++) {
      print(index);
      print(box.getAt(index).title);
      readRoutines.add(box.getAt(index).title);
    }
    routines = readRoutines;
    update();

    print('read items ${box.length}');
  }

  addTimer({String title, int timeout}) async {
    timerList.add(TimerModel(
      title: title,
      index: 1,
      timeout: timeout,
    ));

    String json = jsonEncode(timerList);
    print(json);

    timeList.add(Duration(seconds: timeout));
    activeList = []..addAll(timeList);
    update();
  }

  readTimes() async {}

  start() {
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
  }

  _tick(Timer timer) {
    activeList[_playTime] -= Duration(seconds: 1);
    timerList[_playTime].timeout -= 1;
    if (activeList[_playTime].inSeconds <= 0) {
      _playSound('boop.mp3');
      _playTime += 1;
    } else if (activeList[_playTime].inSeconds <= 3 &&
        activeList[_playTime].inSeconds >= 1) {
      _playSound('pip.mp3');
    }
    if (activeList.length == _playTime) {
      _timer.cancel();
      _playTime = 0;
      activeList = []..addAll(timeList);
      print(activeList);
      print(timeList);
    }
    update();

  }

  Future _playSound(String sound) {
    return player.play(sound);
  }
}
