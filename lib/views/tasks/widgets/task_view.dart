import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/extensions/space_exc.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/views/tasks/widgets/task_component.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  // this is a testing list that it's length is used
  // to generate the same number of tasks
  // and it must be above the build widget to prevent rebuilding it everytime
  List<int> testing = [1];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      // same as a container but adds automatic margin to its elements
      width: double.infinity, // full screen width
      height: double.infinity, // full screen height
      child: Column(
        children: [
          // this is a container for a custom appbar instead of the default
          Container(
            // reduced margin
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 100,
            child: Row(
              // used to center elements horizontally
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  // this widget is used to make a loading progress circle
                  child: CircularProgressIndicator(
                    // used to make 1/3, circle not a full one
                    value: 1 / 3,
                    backgroundColor: Colors.grey,

                    // the color of the value of the progress circle
                    valueColor: AlwaysStoppedAnimation(
                      // doesn't rotate
                      AppColors.primaryColor, // the color of the complete part
                    ),
                  ),
                ),
                25.w, // sharmata mn el course
                Column(
                  // middle at the left
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // header ( My Task )
                    Text(AppStr.mainTitle, style: textTheme.displayLarge),
                    3.h,
                    // this will be calculated
                    Text('1 of 3 tasks', style: textTheme.titleMedium),
                  ],
                ),
              ],
            ),
          ),

          // DIVIDER
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 30,
              endIndent: 30,
              color: AppColors.primaryColor,
            ),
          ),

          // TASKS
          Expanded(
            // checks if there's elements in the list to render the ui
            child: testing.isNotEmpty
                ? ListView.builder(
                    // to iterate over the list and generate the tasks
                    itemCount: testing.length,
                    // to scroll vertically
                    scrollDirection: Axis.vertical,
                    // building the ui
                    itemBuilder: (context, index) {
                      // used for removing the items in the list instead of the index itself
                      final task = testing[index];

                      return Dismissible(
                        key: UniqueKey(),
                        // to dismiss the tasks by swiping left or right
                        direction: DismissDirection.horizontal,
                        // if you dismiss the task:
                        onDismissed: (_) {
                          setState(() {
                            // remove its element from the list
                            testing.remove(task);
                          });
                        },
                        // the background of the task ( will be shown when you dismiss it )
                        background: Row(
                          // to make it at the center of the screen
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // an icon that appears when you swipe
                            Icon(Icons.delete_outline, color: Colors.grey),
                            // a text that appears when you swipe
                            Text(
                              AppStr.deleteTask,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        // the widget (body) of the task component
                        child: TaskComponent(
                          task: Task(
                            id: "1",
                            title: "first task",
                            subTitle: "first task subtitle",
                            createdAtDate: DateTime.now(),
                            createdAtTime: DateTime.now(),
                            isCompleted: true,
                          ),
                        ),
                      );
                    },
                  )
                // if there's no elements in the list:
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // animation
                      FadeIn(
                        key: ValueKey(testing.length),
                        // animation
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 600),
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            // the animation itself
                            child: Lottie.asset(
                              lottieUrl,
                              // show if there's no elements in the list, otherwise, don't show
                              animate: testing.isNotEmpty ? false : true,
                            ),
                          ),
                        ),
                      ),
                      // another animation for the text below the animation
                      FadeInUp(
                        key: ValueKey(testing.length),
                        from: 30,
                        child: Text(
                          AppStr.doneAllTitle,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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
