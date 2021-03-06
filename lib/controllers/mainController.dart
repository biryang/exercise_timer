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
  List<RoutineModel> routineList = [];
  List<TimerModel> timerList = [];
  String playBtn = btnStart;
  RoutineModel selectRoutine;
  int _playTime = 0;
  Timer _timer;
  AudioCache _player = AudioCache();

  selectRoutines(RoutineModel select) {
    selectRoutine = select;
    update();
  }

  addRoutine({String title, int color}) async {
    var _box = await Hive.openBox<RoutineModel>('routines');

    print(color);
    _box.add(
      RoutineModel(title: title, color: color),
    );
    readRoutine();

    print('routine $title add');
  }

  removeRoutine(RoutineModel select) async {
    int _key = select.index;
    var _box = await Hive.openBox<RoutineModel>('routines');
    _box.delete(_key);
    readRoutine();
  }

  readRoutine({String title}) async {
    var _box = await Hive.openBox<RoutineModel>('routines');
    List<RoutineModel> readRoutines = [];
    for (int index = 0; index < _box.length; index++) {
      print('index : $index, key: ${_box.getAt(index).key}, color: ${_box.getAt(index).color}');
      readRoutines.add(RoutineModel(
        index: _box.getAt(index).key,
        title: _box.getAt(index).title,
        color: _box.getAt(index).color,
      ));
    }
    routineList = readRoutines;
    update();
    // _box.clear();
    print('read items ${_box.length}');
  }

  modifyRoutine({String title, int color}) async {
    int _key = selectRoutine.index;
    var _box = await Hive.openBox<RoutineModel>('routines');
    String toJson;

    toJson = jsonEncode(timerList);
    print(toJson);
    _box.put(
        _key,
        RoutineModel(
            title: title,
            index: _box.get(_key).index,
            color: color,
            timerList: _box.get(_key).timerList));
    readRoutine();

    update();
  }

  addTimer({String title, int timeout}) async {
    int _key = selectRoutine.index;
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
        _key,
        RoutineModel(
            title: _box.get(_key).title,
            index: _box.get(_key).index,
            color: _box.get(_key).color,
            timerList: toJson));
    update();
  }

  readTimer() async {
    int _key = selectRoutine.index;
    var _box = await Hive.openBox<RoutineModel>('routines');
    List<TimerModel> _tempList = [];

    print('routineTitle : ${_box.get(_key).title}');
    print('timerList : ${_box.get(_key).timerList}');
    if (_box.get(_key).timerList != null) {
      for (var data in jsonDecode(_box.get(_key).timerList)) {
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

  removeTimer(int index) async {
    int _key = selectRoutine.index;
    var _box = await Hive.openBox<RoutineModel>('routines');
    String toJson;

    timerList.removeAt(index);
    toJson = jsonEncode(timerList);
    print(toJson);
    _box.put(
        _key,
        RoutineModel(
            title: _box.get(_key).title,
            index: _box.get(_key).index,
            color: _box.get(_key).color,
            timerList: toJson));
    update();
  }

  onReorder(int oldIndex, int newIndex) async {
    int _key = selectRoutine.index;
    var _box = await Hive.openBox<RoutineModel>('routines');
    String toJson;

    TimerModel moveTimer = timerList.removeAt(oldIndex);
    timerList.insert(newIndex, moveTimer);
    toJson = jsonEncode(timerList);
    print(toJson);
    _box.put(
        _key,
        RoutineModel(
            title: _box.get(_key).title,
            index: _box.get(_key).index,
            color: _box.get(_key).color,
            timerList: toJson));
    update();
  }

  timerState() {
    switch (playBtn) {
      case btnStart:
        timerStart();
        break;
      case btnStop:
        timerPause();
        break;
    }
  }

  timerPause() {
    playBtn = btnStart;
    _timer.cancel();
    update();
  }

  timerStop() {
    playBtn = btnStart;
    _timer.cancel();
    _playTime = 0;
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
      timerPause();
    }
    update();
  }

  Future _playSound(String sound) {
    return _player.play(sound);
  }
}
