import 'package:exercise_timer/models/routine_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class RoutineController extends GetxController {
  List routines = [];
  List timers = [];

  addRoutine(String routineTitle) async {
    var box = await Hive.openBox<RoutineModel>('routines');
    box.add(
      RoutineModel(
        title: routineTitle,
        index: 1,
      ),
    );
    routines.add(routineTitle);
    update();
    print('routine ${routineTitle} add');
  }

  readRoutine() async {
    var box = await Hive.openBox<RoutineModel>('routines');
    List readRoutines = [];
    for (int index = 0; index < box.length; index++) {
      print(index);
      print(box.getAt(index).title);
      readRoutines.add(box.getAt(index).title);
      print(routines);
    }
    routines = readRoutines;
    update();

    print('read items ${box.length}');
  }

  addTimes({String title, int minutes, int seconds}) async {
    var box = await Hive.openBox<RoutineModel>('routines');
    timers.add(
      TimeModel(title: title, index: 1, minutes: minutes, seconds: seconds),
    );

    box.putAt(0, RoutineModel(timeList: timers));
    update();
  }

  readTimes() async {
    var box = await Hive.openBox<RoutineModel>('routines');
  }
}
