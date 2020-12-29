import 'package:flutter/foundation.dart';
import '../helper/db_helper.dart';

import 'dart:collection';
import '../model/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }


  Future<void> addNewTask(String taskName) async {
    final newTask = Task(taskName: taskName);
    _tasks.add(newTask);

    notifyListeners();

    await DbHelper.insert('user_tasks', {
      'taskName': newTask.taskName,
      'isDone': newTask.isDone.toString(),
    });
  }

  Future<void> updateCheckedTask(Task task) async {
    final isDone = task.toggleCheckBox();

    notifyListeners();

    await DbHelper.update({
      'taskName': task.taskName,
      'isDone': isDone,
    });
  }

  Future<void> deleteTask(Task task) async {
    _tasks.remove(task);
    notifyListeners();

    await DbHelper.delete(
      'user_tasks',
      task.taskName,
    );
  }

  Future<void> fetchAndSetTasks() async {
    final tasksList = await DbHelper.getData('user_tasks');
    tasksList.forEach((task) {
      _tasks.add(
        Task(
          taskName: task['taskName'],
          isDone: task['isDone'] == 1 ? true : false,
        ),
      );
    });
    notifyListeners();
  }
}
