import 'dart:collection';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter/models/task.dart';
import 'package:todo_flutter/screens/taskScreen.dart';

class TaskData extends ChangeNotifier {
  SharedPreferences sharedPreferences;
  initSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  List<Task> _tasks = [];

  int get taskCount {
    return _tasks.length;
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addNewTask(String newTaskTitle) {
    _tasks.add(Task(name: newTaskTitle));
    saveData();
    notifyListeners();
  }

  void deleteTask(Task value) {
    _tasks.remove(value);
    saveData();
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    saveData();
    notifyListeners();
  }

  void saveData() async {
    List<String> spList =
        _tasks.map((item) => json.encode(item.toMap())).toList();
    await initSharedPreference();
    sharedPreferences.setStringList('list', spList);
    print(spList);
  }

  void loadData() {
    List<String> spList = sharedPreferences.getStringList('list');
    _tasks = spList.map((item) => Task.fromMap(json.decode(item))).toList();
    notifyListeners();
  }
}
