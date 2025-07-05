import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/data/hive_data_store.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/tasks/widgets/task_view.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/bloc/task_event.dart';
import 'package:todo_app/views/tasks/widgets/task_view.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>(HiveDataStore.boxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(HiveDataStore())..add(LoadTasks()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-do App',
        theme: ThemeData(
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Colors.black,
              fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            displayMedium: TextStyle(color: Colors.white, fontSize: 21),
            displaySmall: TextStyle(
              color: Color.fromARGB(255, 234, 234, 234),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            headlineMedium: TextStyle(color: Colors.grey, fontSize: 17),
            headlineSmall: TextStyle(color: Colors.grey, fontSize: 16),
            titleSmall: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            titleLarge: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        home: TaskView(),
      ),
    );
  }
}