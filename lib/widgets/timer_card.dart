import 'package:flutter/material.dart';

import '../utils.dart';

class TimerCard extends StatelessWidget {
  final timeout;

  TimerCard(this.timeout);

  @override
  Widget build(BuildContext context) {
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
            formatTime(Duration(seconds: timeout)),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
