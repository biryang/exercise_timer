import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:exercise_timer/widgets/durationpicker.dart';
import 'package:exercise_timer/widgets/new_timer.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Duration> _timeList = [];
  int _playTime = 0;
  Timer _timer;
  Duration _time = Duration(seconds: 10);
  bool _isPlaying = false;
  AudioCache player = AudioCache();

  void _start() {
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
  }

  void _addTimer(Duration timer) {
    setState(() {
      _timeList.add(timer);
    });
  }

  _tick(Timer timer) {
    setState(() {
      _timeList[_playTime] -= Duration(seconds: 1);
      if (_timeList[_playTime].inSeconds <= 0) {
        _playSound('boop.mp3');
        _playTime += 1;
      } else if (_timeList[_playTime].inSeconds <= 3 &&
          _timeList[_playTime].inSeconds >= 1) {
        _playSound('pip.mp3');
      }
      if (_timeList.length == _playTime) {
        _timer.cancel();
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _startAddNewTimer(context);
                  },
                ),
                Text(''),
                IconButton(icon: Icon(Icons.delete)),
                IconButton(icon: Icon(Icons.settings)),
              ],
            ),
          ),
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.white,
      ),
      body: ListView(
        children: _timeList.map((mapTime) {
          return Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // DurationPickerDialog(
                //   initialDuration: Duration(seconds: 0),
                //   title: Text('타이머'),
                // )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
