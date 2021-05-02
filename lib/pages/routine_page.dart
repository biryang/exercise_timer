import 'package:exercise_timer/controllers/mainController.dart';
import 'package:exercise_timer/pages/setting_page.dart';
import 'package:exercise_timer/pages/timer_page.dart';
import 'package:exercise_timer/widgets/new_routine_card.dart';
import 'package:exercise_timer/widgets/routine_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoutinePage extends StatelessWidget {
  final controller = Get.put(MainController());

  void onRoute(Map<int, String> data) {
    Get.to(TimerPage(
      routineKey: data.keys.first,
      routineValue: data.values.first,
    ),transition: Transition.fadeIn);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (_) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   tooltip: 'Increment',
          //   child: Icon(Icons.play_arrow),
          //   elevation: 2.0,
          // ),
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
                      onPressed: () {
                        controller.readRoutine();
                      },
                    ),
                    Text(''),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Get.to(SettingPage());
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    '루틴을 추가해주세요!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: (controller.routineList.map((_data) {
                          return Container(
                            child: RoutineCard(
                              title: '${_data.values.first}',
                              onTap: () => onRoute(_data),
                            ),
                          );
                        }).toList()) +
                        [Container(child: NewRoutineCard())],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
