import 'package:exercise_timer/controllers/mainController.dart';
import 'package:exercise_timer/widgets/input_routine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class NewRoutineCard extends StatelessWidget {
  final controller = Get.put(MainController());

  void _addTimer(String title, int color) {
    controller.addRoutine(title: title, color: color);
  }

  void _startAddNewTimer(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: InputRoutine(inputRoutine: _addTimer),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _startAddNewTimer(context);
      },
      child: Container(
        margin: kCardMargin,
        padding: kCardPadding,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000000).withOpacity(0.25),
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
