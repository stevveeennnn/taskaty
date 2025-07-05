import 'package:equatable/equatable.dart';
import 'package:todo_app/models/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TasksLoading extends TaskState {}

class TasksLoaded extends TaskState {
  // final List<Task> facs;
  final List<Task> tasks;

  const TasksLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskOperationSuccess extends TaskState {
  final String message;

  const TaskOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TaskOperationFailure extends TaskState {
  final String error;

  const TaskOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}
