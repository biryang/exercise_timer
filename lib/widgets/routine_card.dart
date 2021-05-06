import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class RoutineCard extends StatelessWidget {
  final Function onTap;
  final Function onIconBtn;
  final String title;
  final Widget icon;
  final int color;

  RoutineCard({this.title, this.onTap, this.icon, this.onIconBtn, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: kCardMargin,
        padding: kCardPadding,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(color), Color(0xFF5FC6FF)],
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$title',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                IconButton(
                  icon: icon,
                  onPressed: onIconBtn,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Time : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
