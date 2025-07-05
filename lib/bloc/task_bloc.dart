import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:todo_app/data/hive_data_store.dart';
import 'package:todo_app/models/task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final HiveDataStore _dataStore;

  TaskBloc(this._dataStore) : super(TasksLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<DeleteAllTasks>(_onDeleteAllTasks);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    try {
      final tasks = _dataStore.box.values.toList();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TaskOperationFailure('Failed to load tasks: $e'));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    try {
      await _dataStore.addTask(task: event.task);
      emit(TaskOperationSuccess('Task added successfully'));
      add(LoadTasks());
    } catch (e) {
      emit(TaskOperationFailure('Failed to add task: $e'));
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    try {
      await _dataStore.updateTask(task: event.task);
      emit(TaskOperationSuccess('Task updated successfully'));
      add(LoadTasks());
    } catch (e) {
      emit(TaskOperationFailure('Failed to update task: $e'));
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await _dataStore.deleteTask(task: event.task);
      emit(TaskOperationSuccess('Task deleted successfully'));
      add(LoadTasks());
    } catch (e) {
      emit(TaskOperationFailure('Failed to delete task: $e'));
    }
  }

  Future<void> _onDeleteAllTasks(DeleteAllTasks event, Emitter<TaskState> emit) async {
    try {
      await _dataStore.deleteAllTasks();
      emit(TaskOperationSuccess('All tasks deleted successfully'));
      add(LoadTasks());
    } catch (e) {
      emit(TaskOperationFailure('Failed to delete all tasks: $e'));
    }
  }
}