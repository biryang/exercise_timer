import 'package:exercise_timer/controllers/mainController.dart';
import 'package:exercise_timer/pages/setting_page.dart';
import 'package:exercise_timer/pages/timer_page.dart';
import 'package:exercise_timer/widgets/new_routine.dart';
import 'package:exercise_timer/widgets/new_routine_card.dart';
import 'package:exercise_timer/widgets/routine_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RoutinePage extends StatelessWidget {
  final controller = Get.put(MainController());

  void onRutine(Map<int, String> data) {
    controller.selectRoutines(data);
    Get.to(TimerPage(), transition: Transition.fadeIn);
  }

  void _modifyRoutine(String title) {
    controller.modifyRoutine(title: title);
  }

  void _onIconBtn(BuildContext ctx, Map<int, String> data) {
    controller.selectRoutines(data);
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewRoutine(_modifyRoutine),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
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
                              onTap: () => onRutine(_data),
                              icon: FaIcon(FontAwesomeIcons.edit),
                              onIconBtn: () => _onIconBtn(context, _data),
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
