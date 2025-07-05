import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/task.dart';


// all the CRUD operations for hive db
class HiveDataStore {
  // boxName - string
  static const boxName = 'taskBox';

  //our current box with all of the saved data inside - Box<Task>
  final Box<Task> box = Hive.box<Task>(boxName);

  // add new task to the box
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  // show task
  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  // update task
  Future<Task?> updateTask({required Task task}) async {
    await task.save();
  }

  // delete task
  Future<Task?> deleteTask({required Task task}) async {
    await task.delete();
  }

  // listen to the changes of the box
  // using this method we will listen to the box changes and update 
  // the UI accordingly
  ValueListenable<Box<Task>> listenToTask() => box.listenable();
}
