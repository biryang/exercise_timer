import 'package:exercise_timer/controllers/mainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_timer.dart';

class NewTimerCard extends StatelessWidget {
  final int routineKey;

  NewTimerCard(this.routineKey);

  final controller = Get.put(MainController());

  void _startAddNewTimer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          child: NewTimer(routineKey),
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
