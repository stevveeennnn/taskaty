import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/models/task.dart';

class HiveDataStore {
  static const boxName = 'taskBox';
  final Box<Task> box = Hive.box<Task>(boxName);

  Future<void> addTask({required Task task}) async {
    try {
      await box.put(task.id, task);
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  Future<Task?> getTask({required String id}) async {
    try {
      return box.get(id);
    } catch (e) {
      throw Exception('Failed to get task: $e');
    }
  }

  Future<void> updateTask({required Task task}) async {
    try {
      await task.save();
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> deleteTask({required Task task}) async {
    try {
      await task.delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  Future<void> deleteAllTasks() async {
    try {
      await box.clear();
    } catch (e) {
      throw Exception('Failed to delete all tasks: $e');
    }
  }

  ValueListenable<Box<Task>> listenToTask() => box.listenable();
}