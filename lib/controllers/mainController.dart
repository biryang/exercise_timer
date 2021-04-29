import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:exercise_timer/models/routine_model.dart';
import 'package:exercise_timer/models/timer_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

const btnStart = 'start';
const btnStop = 'stop';

class MainController extends GetxController {
  List<Map<int, String>> routineList = [];
  List<TimerModel> timerList = [];
  String playBtn = btnStart;
  int _playTime = 0;
  Timer _timer;
  AudioCache _player = AudioCache();

  addRoutine(String routineTitle) async {
    var _box = await Hive.openBox<RoutineModel>('routines');
    _box.add(
      RoutineModel(
        title: routineTitle,
        index: 1,
      ),
    );
    readRoutine();

    print('routine $routineTitle add');
  }

  readRoutine() async {
    var _box = await Hive.openBox<RoutineModel>('routines');
    List<Map<int, String>> readRoutines = [];
    for (int index = 0; index < _box.length; index++) {
      print('index : $index, key: ${_box.getAt(index).key}');
      readRoutines.add({_box.getAt(index).key: _box.getAt(index).title});
    }
    routineList = readRoutines;
    update();

    print('read items ${_box.length}');
  }

  addTimer({int key, String title, int timeout}) async {
    var _box = await Hive.openBox<RoutineModel>('routines');
    String toJson;
    timerList.add(TimerModel(
      title: title,
      index: 1,
      timeout: timeout,
    ));

    toJson = jsonEncode(timerList);
    print(toJson);
    _box.put(
        key,
        RoutineModel(
            title: _box.get(key).title,
            index: _box.get(key).index,
            timerList: toJson));
    update();
  }

  readTimer({int key}) async {
    var _box = await Hive.openBox<RoutineModel>('routines');
    List<TimerModel> _tempList = [];

    print('routineTitle : ${_box.get(key).title}');
    print('timerList : ${_box.get(key).timerList}');
    if (_box.get(key).timerList != null) {
      for (var data in jsonDecode(_box.get(key).timerList)) {
        _tempList.add(TimerModel(
            title: data['title'],
            index: data['index'],
            timeout: data['timeout']));
      }
      timerList = []..addAll(_tempList);
    } else {
      timerList = [];
    }
    update();
  }

  timerState() {
    switch (playBtn) {
      case btnStart:
        timerStart();
        break;
      case btnStop:
        timerStop();
        break;
    }
  }

  timerStop() {
    playBtn = btnStart;
    _timer.cancel();
    update();
  }

  timerStart() {
    playBtn = btnStop;
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
    update();
  }

  _tick(Timer timer) {
    timerList[_playTime].timeout -= 1;
    if (timerList[_playTime].timeout <= 0) {
      _playSound('boop.mp3');
      _playTime += 1;
    } else if (timerList[_playTime].timeout <= 3 &&
        timerList[_playTime].timeout >= 1) {
      _playSound('pip.mp3');
    }
    if (timerList.length == _playTime) {
      _timer.cancel();
      _playTime = 0;
    }
    update();
  }

  Future _playSound(String sound) {
    return _player.play(sound);
  }
}
