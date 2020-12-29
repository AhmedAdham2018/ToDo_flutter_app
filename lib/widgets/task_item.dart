import 'package:flutter/material.dart';

class TaskItemTile extends StatelessWidget {
  final String taskTitle;
  final bool checkBoxState;
  final Function checkBoxStateHandler;
  final Function longPressHandler;

  TaskItemTile(
      {@required this.taskTitle,
      @required this.checkBoxState,
      @required this.checkBoxStateHandler,
      @required this.longPressHandler});

  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        taskTitle,
        style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            decoration: checkBoxState ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
          value: checkBoxState,
          activeColor: Colors.lightBlue,
          onChanged: checkBoxStateHandler),
      onLongPress: longPressHandler,
    );
  }
}
