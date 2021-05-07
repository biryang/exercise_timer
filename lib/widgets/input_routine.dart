import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class NewRoutine extends StatefulWidget {
  final Function addRoutine;

  NewRoutine(this.addRoutine);

  @override
  _NewRoutineState createState() => _NewRoutineState();
}

class _NewRoutineState extends State<NewRoutine> {
  final titleController = TextEditingController();
  int color = 0xffff5252;
  int minutes = 0;
  int seconds = 0;

  void _submitData() {
    print(color);
    setState(() {
      widget.addRoutine(titleController.text, color);
    });
    Navigator.pop(context);
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Routine Name'),
                controller: titleController,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Select Card Color'),
              Divider(),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ColorPicker(
                    onColorChanged: (Color selColor) => {color = selColor.value},
                    color: Color(0xffff5252),
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
