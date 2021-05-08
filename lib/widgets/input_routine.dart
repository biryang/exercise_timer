import 'package:exercise_timer/controllers/mainController.dart';
import 'package:exercise_timer/models/routine_model.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class InputRoutine extends StatefulWidget {
  final Function inputRoutine;
  final RoutineModel routine;

  InputRoutine({this.inputRoutine, this.routine});

  @override
  _InputRoutineState createState() => _InputRoutineState();
}

class _InputRoutineState extends State<InputRoutine> {
  final controller = Get.put(MainController());

  final titleController = TextEditingController();
  int color = 0xffff5252;
  int minutes = 0;
  int seconds = 0;

  void _submitData() {
    if (titleController.text == null) {
      // titleController.er
    }
    print(color);
    setState(() {
      widget.inputRoutine(titleController.text, color);
    });
    Navigator.pop(context);
  }

  void _onRemove(BuildContext ctx, RoutineModel data) {
    showDialog(
      context: ctx,
      builder: (_) {
        return AlertDialog(
          title: Text("삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                controller.removeRoutine(data);
                Navigator.pop(ctx);
                Navigator.pop(ctx);
              },
              child: Text('삭제'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.routine != null) {
      setState(() {
        color = widget.routine.color;
        titleController.text = widget.routine.title;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Routine',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: widget.routine != null
                      ? IconButton(
                          onPressed: () {
                            _onRemove(context, widget.routine);
                          },
                          icon: Icon(Icons.delete),
                          alignment: Alignment.centerRight,
                        )
                      : SizedBox(),
                ),
              ],
            ),
            Divider(),
            TextFormField(
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  hintText: 'Enter Title',
                  border: InputBorder.none),
              controller: titleController,
            ),
            Divider(),
            SizedBox(height: 20),
            Text('Select Card Color'),
            SizedBox(height: 20),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ColorPicker(
                  onColorChanged: (Color selColor) => {color = selColor.value},
                  color: Color(color),
                  padding: EdgeInsets.all(0.0),
                  spacing: 10,
                  borderRadius: 20,
                  elevation: 2,
                  enableShadesSelection: false,
                  pickersEnabled: {
                    ColorPickerType.both: false,
                    ColorPickerType.primary: false,
                    ColorPickerType.accent: true,
                    ColorPickerType.bw: false,
                    ColorPickerType.custom: false,
                    ColorPickerType.wheel: false,
                  },
                ),
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
                      onPressed: titleController.text.isNotEmpty ? _submitData : null,
                      child: Text('SAVE'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
