import 'package:exercise_timer/controllers/routineController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class NewTimer extends StatefulWidget {
  NewTimer();

  @override
  _NewTimerState createState() => _NewTimerState();
}

class _NewTimerState extends State<NewTimer> {
  final controller = Get.put(RoutineController());
  final titleController = TextEditingController();
  int minutes = 0;
  int seconds = 0;

  void _submitData() {
    print(titleController.text);
    print('${minutes}');
    print('${seconds}');
    controller.addTimes(
      title: titleController.text,
      minutes: minutes,
      seconds: seconds,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new NumberPicker(
                      value: minutes,
                      minValue: 0,
                      maxValue: 10,
                      zeroPad: true,
                      onChanged: (value) {
                        this.setState(() {
                          minutes = value;
                        });
                      },
                    ),
                    Text(
                      ':',
                      style: TextStyle(fontSize: 30),
                    ),
                    new NumberPicker(
                      value: seconds,
                      minValue: 0,
                      maxValue: 59,
                      zeroPad: true,
                      onChanged: (value) {
                        this.setState(() {
                          seconds = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('CANCEL'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: _submitData,
                        child: Text('ADD'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
