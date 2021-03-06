import 'package:exercise_timer/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils.dart';

class TimerCard extends StatelessWidget {
  final key;
  final title;
  final timeout;
  final onRemove;

  TimerCard({this.key, this.title, this.timeout, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24),
              ),
              Text(
                formatTime(Duration(seconds: timeout)),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.trash),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
