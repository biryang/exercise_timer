import 'package:flutter/material.dart';

class RoutineCard extends StatelessWidget {
  final Function onTap;
  final String title;

  RoutineCard({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              '$title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
