import 'package:exercise_timer/controllers/mainController.dart';
import 'package:exercise_timer/widgets/new_routine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewRoutineCard extends StatelessWidget {
  final controller = Get.put(MainController());

  void _addTimer(String title) {
    controller.addRoutine(title);
  }

  void _startAddNewTimer(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewRoutine(_addTimer),
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
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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