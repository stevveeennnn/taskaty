import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/views/tasks/widgets/task_details.dart';
import 'package:todo_app/views/tasks/widgets/task_component.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/bloc/task_event.dart';
import 'package:todo_app/bloc/task_state.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TasksLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TasksLoaded) {
            final tasks = state.tasks;
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          value: tasks.isEmpty
                              ? 0
                              : tasks.where((task) => task.isCompleted).length /
                                  tasks.length,
                          backgroundColor: Colors.grey,
                          valueColor:
                              AlwaysStoppedAnimation(Colors.blue),
                        ),
                      ),
                      SizedBox(width: 25),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('To-do List',
                              style: Theme.of(context).textTheme.displayLarge),
                          SizedBox(height: 3),
                          Text('${tasks.length} tasks',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Divider(
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: tasks.isNotEmpty
                      ? ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return Dismissible(
                              key: ValueKey(task.id),
                              direction: DismissDirection.horizontal,
                              onDismissed: (_) {
                                context.read<TaskBloc>().add(DeleteTask(task));
                              },
                              background: Container(
                                color: Colors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete_outline,
                                        color: Colors.white),
                                    Text('Delete',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                              child: TaskComponent(task: task),
                            );
                          },
                        )
                      : Center(child: Text('No tasks yet')),
                ),
              ],
            );
          } else if (state is TaskOperationFailure) {
            return Center(child: Text(state.error));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskDetails()),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}