import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/data/hive_data_store.dart';
import 'package:todo_app/models/task.dart';

class TaskProvider with ChangeNotifier {
  final HiveDataStore _dataStore = HiveDataStore();
  List<Task> get tasks => _dataStore.box.values.toList();

  Future<void> addTask(Task task) async {
    await _dataStore.addTask(task: task);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await _dataStore.updateTask(task: task);
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    await _dataStore.deleteTask(task: task);
    notifyListeners();
  }

  ValueListenable<Box<Task>> listenToTasks() => _dataStore.listenToTask();
}
