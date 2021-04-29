import 'dart:convert';

class TimerModel {
  int index;
  String title;
  int timeout;

  TimerModel({this.title, this.index, this.timeout});

  Map<String, dynamic> toJson() => {
        'title': title,
        'index': index,
        'timeout': timeout,
      };
}
