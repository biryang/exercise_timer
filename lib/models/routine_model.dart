import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'routine_model.g.dart';

@HiveType(typeId: 1)
class RoutineModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  int index;
  @HiveField(2)
  String timerList;
  @HiveField(3)
  int color;

  RoutineModel({
    this.title,
    this.index,
    this.timerList,
    this.color,
  });
}
