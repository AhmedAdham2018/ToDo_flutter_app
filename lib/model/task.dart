class Task {
  final String taskName;
  bool isDone;
  Task({this.taskName, this.isDone = false});

  int toggleCheckBox() {
    isDone = !isDone;
    if (isDone == true) {
      return 1;
    } else {
      return 0;
    }
  }
}
