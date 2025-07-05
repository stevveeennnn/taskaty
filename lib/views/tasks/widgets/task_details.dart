import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:todo_app/extensions/space_exc.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/views/tasks/components/custom_text_field.dart';
import 'package:todo_app/views/tasks/widgets/task_details_app_bar.dart';
import 'package:todo_app/views/tasks/widgets/date_time_selection.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({
    super.key,
    required this.titleTaskController,
    required this.descriptionTaskController,
    required this.task,
  });

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskController;
  final Task? task;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  bool isTaskExist() {
    if (widget.titleTaskController?.text == null &&
        widget.titleTaskController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: TaskDetailsAppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                _buildTopSideText(textTheme, isTaskExist),

                MainTaskDetailsActivity(
                  textTheme: textTheme,
                  controller: widget.titleTaskController, // ✅ هنا
                  descriptionTaskController:
                      widget.descriptionTaskController, // ✅ وهنا
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainTaskDetailsActivity extends StatelessWidget {
  const MainTaskDetailsActivity({
    super.key,
    required this.textTheme,
    required this.controller,
    required this.descriptionTaskController,
  });

  final TextTheme textTheme;
  final TextEditingController? controller;
  final TextEditingController? descriptionTaskController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          20.h,

          // task title
          CustomTextField(controller: controller),
          20.h,
          CustomTextField(
            controller: descriptionTaskController,
            isForDescription: true,
          ),

          20.h,

          // time selection
          DateTimeSelection(
            title: AppStr.timeString,
            textTheme: textTheme,
            onTap: (BuildContext context) async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Colors.orange,
                        onPrimary: Colors.white,
                        onSurface: Colors.orange,
                        secondary: Colors.orange,
                        onSecondary: Colors.white,
                      ),
                      timePickerTheme: TimePickerThemeData(
                        dialHandColor: Colors.orange,
                        dialBackgroundColor: Colors.orangeAccent.withOpacity(
                          0.1,
                        ),
                        entryModeIconColor: Colors.orange,
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (timeOfDay != null) {
                print("Selected Time: ${timeOfDay.format(context)}");
              }
            },
          ),

          // date selection
          DateTimeSelection(
            title: AppStr.dateString,
            textTheme: textTheme,
            onTap: (BuildContext context) {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2030, 12, 31),
                minDateTime: DateTime.now(),
                onConfirm: (dateTime, _) {
                  print("Selected date: $dateTime"); // استخدم القيمة هنا
                },
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Row(
              children: [
                MaterialButton(
                  onPressed: () {},
                  color: Colors.white,
                  textColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  minWidth: 150,
                  height: 50,
                  child: Row(
                    children: [
                      Icon(Icons.close_rounded),
                      Padding(padding: EdgeInsetsGeometry.only(right: 5)),
                      Text('Delete Task'),
                    ],
                  ),
                ),

                Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 10)),

                MaterialButton(
                  onPressed: () {},
                  color: AppColors.primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  minWidth: 150,
                  height: 50,
                  child: Row(
                    children: [
                      Icon(Icons.check_rounded),
                      Padding(padding: EdgeInsetsGeometry.only(right: 5)),
                      Text('Add Task'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTopSideText(TextTheme textTheme, bool Function() isTaskExist) {
  return SizedBox(
    width: double.infinity,
    height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: isTaskExist() ? AppStr.addNewTask : AppStr.updateTaskString,
            style: textTheme.titleLarge,
          ),
        ),
      ],
    ),
  );
}
