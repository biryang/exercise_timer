import 'package:hive/hive.dart';

part 'routine_model.g.dart';

@HiveType(typeId: 1)
class RoutineModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  int index;
  @HiveField(2)
  List timeList;

  RoutineModel({
    this.title,
    this.index,
    this.timeList,
  });
}

@HiveType(typeId: 2)
class TimeModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  int index;
  @HiveField(2)
  int minutes = 0;
  @HiveField(3)
  int seconds = 0;

  TimeModel({
    this.title,
    this.index,
    this.minutes,
    this.seconds,
  });
}
