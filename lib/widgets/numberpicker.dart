import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPickerDialog extends StatefulWidget {
  final int initialNumber;
  final EdgeInsets titlePadding;
  final Widget title;
  final Widget confirmWidget;
  final Widget cancelWidget;

  NumberPickerDialog({
    @required this.initialNumber,
    this.title,
    this.titlePadding,
    Widget confirmWidget,
    Widget cancelWidget,
  })  : confirmWidget = confirmWidget ?? new Text('OK'),
        cancelWidget = cancelWidget ?? new Text('CANCEL');

  @override
  State<StatefulWidget> createState() =>
      new _NumberPickerDialogState(initialNumber);
}

class _NumberPickerDialogState extends State<NumberPickerDialog> {
  int reps;
  int seconds;

  _NumberPickerDialogState(int initialNumber) {
    reps = initialNumber;
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: widget.title,
      titlePadding: widget.titlePadding,
      content: new NumberPicker(
        // listViewWidth: 65,
        // initialValue: reps,
        value: reps,
        minValue: 0,
        maxValue: 10,
        zeroPad: true,
        onChanged: (value) {
          this.setState(() {
            reps = value;
          });
        },
      ),
      actions: [
        new TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: widget.cancelWidget,
        ),
        new TextButton(
          onPressed: () => Navigator.of(context).pop(reps),
          child: widget.confirmWidget,
        ),
      ],
    );
  }
}
