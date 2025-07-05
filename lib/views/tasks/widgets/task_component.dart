import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/app_colors.dart';

class TaskComponent extends StatefulWidget {
  const TaskComponent({super.key, required this.task});

  final Task task;

  @override
  State<TaskComponent> createState() => _TaskComponentState();
}

class _TaskComponentState extends State<TaskComponent> {
  TextEditingController textEditingControllerForTitle = TextEditingController();
  TextEditingController textEditingControllerForSubtitle =
      TextEditingController();

  @override
  void initState() {
    textEditingControllerForTitle.text = widget.task.title;
    textEditingControllerForSubtitle.text = widget.task.subTitle;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerForTitle.dispose();
    textEditingControllerForSubtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // a widget that detects any touch
    return GestureDetector(
      onTap: () {
        // navigate to task view to see details
      },
      // for animations
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          // to give it a circular border
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            // to make a shadow below it
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              // the intensity of the shadow
              offset: const Offset(0, 4),
              // the intensity of the blur
              blurRadius: 10,
            ),
          ],
          color: widget.task.isCompleted
              ? AppColors.primaryColor.withOpacity(0.1)
              : Colors.white,
        ),
        duration: Duration(milliseconds: 600),
        // listTile is a widget that displays items in a good way
        child: ListTile(
          // check icon
          leading: GestureDetector(
            onTap: () {
              // check or uncheck
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: widget.task.isCompleted
                    ? AppColors.primaryColor
                    : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8),
              ),
              child: Icon(Icons.check, color: Colors.white),
            ),
          ),

          // Task Title
          title: Padding(
            padding: EdgeInsets.only(top: 3, bottom: 5),
            child: Text(
              textEditingControllerForTitle.text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                decoration: widget.task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),

          // Task Description
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              textEditingControllerForSubtitle.text,
                style: TextStyle(
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              // a widget used to align items in a grid-like manner
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        // DateFormat('y/M/d').format(task.createdAtDate),
                        DateFormat.yMMMEd().format(widget.task.createdAtDate),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createdAtTime),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
