import 'package:exercise_timer/models.dart';
import 'package:exercise_timer/models/routine_model.dart';
import 'package:exercise_timer/pages/timer_page.dart';
import 'package:exercise_timer/pages/routine_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'controllers/mainController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();

  await Hive.initFlutter();
  Hive.registerAdapter(RoutineModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    controller.readRoutine();

    return GetMaterialApp(
      home: RoutinePage(),
      // getPages: [
      //   GetPage(
      //     name: 'timer_page',
      //     page: () => TimerPage(),
      //   ),
      //   GetPage(
      //     name: 'routine_page',
      //     page: () => RoutinePage(),
      //   ),
      // ],
      theme: ThemeData(fontFamily: 'NotoSans'),
    );
  }
}
