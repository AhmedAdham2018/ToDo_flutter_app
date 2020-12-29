import 'package:flutter/material.dart';
import 'package:flutter_app/provider/task_data.dart';
import 'package:provider/provider.dart';

import '../widgets/task_item.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      child: Container(
        padding: const EdgeInsets.all(25.0),
        width: double.infinity,
        child: Center(
          child: Text(
            'No Tasks Added yet , please add one.',
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ),
      ),
      builder: (context, taskData, ch) {
        return taskData.tasks.length <= 0
            ? ch
            : ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItemTile(
                    taskTitle: taskData.tasks[index].taskName,
                    checkBoxState: taskData.tasks[index].isDone,
                    checkBoxStateHandler: (_) {
                      taskData.updateCheckedTask(taskData.tasks[index]);
                    },
                    longPressHandler: () {
                      taskData.deleteTask(taskData.tasks[index]);
                    },
                  );
                },
                itemCount: taskData.taskCount,
              );
      },
    );
  }
}
