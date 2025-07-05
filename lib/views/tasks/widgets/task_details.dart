import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_state.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/bloc/task_event.dart';

class TaskDetails extends StatefulWidget {
  final Task? task;
  const TaskDetails({super.key, this.task});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      noteController.text = widget.task!.subTitle;
      selectedDate = widget.task!.createdAtDate;
      selectedTime = TimeOfDay.fromDateTime(widget.task!.createdAtTime);
      isCompleted = widget.task!.isCompleted;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskOperationSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is TaskOperationFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.task == null ? 'New Task' : 'Edit Task'),
          actions: [
            if (widget.task != null)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  context.read<TaskBloc>().add(DeleteTask(widget.task!));
                  Navigator.pop(context);
                },
              ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: noteController,
                decoration: InputDecoration(labelText: 'Note'),
              ),
              ListTile(
                title: Text(selectedDate == null
                    ? 'Select Date'
                    : selectedDate!.toString().split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) setState(() => selectedDate = date);
                },
              ),
              ListTile(
                title: Text(selectedTime == null
                    ? 'Select Time'
                    : selectedTime!.format(context)),
                trailing: Icon(Icons.access_time),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) setState(() => selectedTime = time);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      noteController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields')));
                    return;
                  }
                  final task = Task.create(
                    title: titleController.text,
                    subTitle: noteController.text,
                    createdAtDate: selectedDate ?? DateTime.now(),
                    createdAtTime: DateTime.now().copyWith(
                      hour: selectedTime?.hour ?? TimeOfDay.now().hour,
                      minute: selectedTime?.minute ?? TimeOfDay.now().minute,
                    ),
                    isCompleted: isCompleted,
                  );
                  if (widget.task == null) {
                    context.read<TaskBloc>().add(AddTask(task));
                  } else {
                    context.read<TaskBloc>().add(
                        UpdateTask(task.copyWith(id: widget.task!.id)));
                  }
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}