import 'package:exercise_timer/controllers/mainController.dart';
import 'package:exercise_timer/widgets/new_timer_card.dart';
import 'package:exercise_timer/widgets/timer_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';

class TimerPage extends StatelessWidget {
  final int routineKey;
  final String routineValue;

  TimerPage({this.routineKey, this.routineValue});

  final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    controller.readTimer(key: routineKey);
    return GetBuilder<MainController>(
      builder: (_) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.timerState();
            },
            tooltip: 'Increment',
            child: controller.playBtn == btnStart
                ? Icon(Icons.play_arrow)
                : Icon(Icons.pause),
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
                      onPressed: () {},
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
                    '${this.routineKey} : ${this.routineValue}\n타이머를 추가해주세요!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ReorderableColumn(
                        enabled: true,
                        onReorder: _.onReorder,
                        draggingWidgetOpacity: 0,
                        children: (_.timerList.map((_data) {
                              return Container(
                                key: ValueKey(_data.timeout),
                                child: TimerCard(
                                  title: _data.title,
                                  timeout: _data.timeout,
                                ),
                              );
                            }).toList()) +
                            [
                              Container(
                                  key: ValueKey(10),
                                  child: NewTimerCard(routineKey))
                            ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
