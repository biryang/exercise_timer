import 'package:exercise_timer/models/routine_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class RoutineController extends GetxController {
  List routines = [];

  addRoutine() async {
    var box = await Hive.openBox<RoutineModel>('routines');
    box.put(
      1,
      RoutineModel(
        title: 'test',
        index: 1,
      ),
    );
    update();
    print('add');
  }

  readRoutine() async {
    var box = await Hive.openBox<RoutineModel>('routines');
    print('${box.get(1).index}');
    update();
    print('read');
  }
}
