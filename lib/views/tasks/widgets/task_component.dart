import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/tasks/widgets/task_details.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/bloc/task_event.dart';
import 'package:intl/intl.dart';

class TaskComponent extends StatelessWidget {
  final Task task;

  const TaskComponent({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TaskDetails(task: task)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: task.isCompleted ? Colors.grey[200] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.read<TaskBloc>().add(
                    UpdateTask(task.copyWith(isCompleted: !task.isCompleted)));
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: task.isCompleted ? Colors.blue : Colors.white,
                  border: Border.all(color: Colors.grey),
                ),
                child: task.isCompleted
                    ? Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  Text(task.subTitle),
                  Text(
                    '${DateFormat.yMMMEd().format(task.createdAtDate)} ${DateFormat('hh:mm a').format(task.createdAtTime)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}