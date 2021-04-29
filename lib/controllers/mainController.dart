import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:exercise_timer/models/routine_model.dart';
import 'package:exercise_timer/models/timer_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MainController extends GetxController {
  List<Map<int, String>> routineList = [];
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
    readRoutine();

    print('routine $routineTitle add');
  }

  readRoutine() async {
    var box = await Hive.openBox<RoutineModel>('routines');
    List<Map<int, String>> readRoutines = [];
    for (int index = 0; index < box.length; index++) {
      print('index : $index, key: ${box.getAt(index).key}');
      readRoutines.add({box.getAt(index).key: box.getAt(index).title});
    }
    routineList = readRoutines;
    update();

    print('routineList');
    print(routineList);
    print('read items ${box.length}');
  }

  addTimer({int key, String title, int timeout}) async {
    var box = await Hive.openBox<RoutineModel>('routines');
    String toJson;
    timerList.add(TimerModel(
      title: title,
      index: 1,
      timeout: timeout,
    ));

    toJson = jsonEncode(timerList);
    print(toJson);
    box.put(
        key,
        RoutineModel(
            title: box.get(key).title,
            index: box.get(key).index,
            timerList: toJson));

    timeList.add(Duration(seconds: timeout));
    activeList = []..addAll(timeList);
    readRoutine();
    readTimer(key: key);
  }

  readTimer({int key}) async {
    var box = await Hive.openBox<RoutineModel>('routines');
    List<TimerModel> _tempList = [];

    print('routineTitle : ${box.get(key).title}');
    print('timerList : ${box.get(key).timerList}');
    print('========Decode========');
    // print(jsonDecode(box.get(key).timerList)[0]['timeout']);
    if (box.get(key).timerList != null) {
      for (var data in jsonDecode(box.get(key).timerList)) {
        _tempList.add(TimerModel(
            title: data['title'],
            index: data['index'],
            timeout: data['timeout']));
      }
      timerList = []..addAll(_tempList);
    }else{
      timerList = [];
    }
    print('========List========');
    print(timerList);
    update();
  }

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
