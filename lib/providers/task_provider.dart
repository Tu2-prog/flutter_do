import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  late Box<Task> _taskBox;

  TaskProvider() {
    _init();
  }

  Future<void> _init() async {
    _taskBox = await Hive.openBox<Task>('tasks');
  }

  Future<List<Task>> get tasks async {
    await _init(); // Ensure _taskBox is initialized
    return _taskBox.values.toList();
  }

  void addTask(Task task) {
    _taskBox.put(task.id, task);
    notifyListeners();
  }

  void completeTask(String taskId, bool isDone) {
  final task = _taskBox.get(taskId);
  if (task != null) {
    task.isDone = isDone;
    _taskBox.put(taskId, task);
    notifyListeners();

    Fluttertoast.showToast(
      msg: 'Task completed!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Delayed task removal with fade-out animation
    Future.delayed(Duration(seconds: 1), () {
      // Find the index of the task
      int taskIndex = _taskBox.values.toList().indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        _taskBox.deleteAt(taskIndex);
        notifyListeners();
      }
    });
  }
}

}
