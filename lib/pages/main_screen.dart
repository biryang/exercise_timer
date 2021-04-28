import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:exercise_timer/controllers/routineController.dart';
import 'package:exercise_timer/widgets/new_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Duration> _timeList = [];
  List<Duration> _activeList = [];
  int _playTime = 0;
  Timer _timer;
  AudioCache player = AudioCache();

  final controller = Get.put(RoutineController());

  void _start() {
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
  }

  void _addTimer(Duration timer) {
    setState(() {
      _timeList.add(timer);
      _activeList = []..addAll(_timeList);
    });
  }

  _tick(Timer timer) {
    setState(() {
      _activeList[_playTime] -= Duration(seconds: 1);
      if (_activeList[_playTime].inSeconds <= 0) {
        _playSound('boop.mp3');
        _playTime += 1;
      } else if (_activeList[_playTime].inSeconds <= 3 &&
          _activeList[_playTime].inSeconds >= 1) {
        _playSound('pip.mp3');
      }
      if (_activeList.length == _playTime) {
        _timer.cancel();
        _playTime = 0;
        _activeList = []..addAll(_timeList);
        print(_activeList);
        print(_timeList);
      }
    });
  }

  Future _playSound(String sound) {
    return player.play(sound);
  }

  void _startAddNewTimer(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTimer(_addTimer),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _start();
        },
        tooltip: 'Increment',
        child: Icon(Icons.play_arrow),
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {},
                ),
                Text(''),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    controller.addRoutine();
                    controller.readRoutine();
                  },
                ),
              ],
            ),
          ),
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '타이머를 추가해주세요!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView(
                  children: (_activeList.map((mapTime) {
                        return Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF6448FE), Color(0xFF5FC6FF)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF5FC6FF).withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(4, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                formatTime(mapTime),
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              // DurationPickerDialog(
                              //   initialDuration: Duration(seconds: 0),
                              //   title: Text('타이머'),
                              // )
                            ],
                          ),
                        );
                      }).toList()) +
                      [
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              _startAddNewTimer(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF000000).withOpacity(0.25),
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                              ),
                              child: Icon(Icons.add),
                            ),
                          ),
                        )
                      ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
