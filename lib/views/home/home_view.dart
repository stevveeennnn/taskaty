import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todo_app/views/tasks/components/fab.dart';
import 'package:todo_app/views/home/home_app_bar.dart';
import 'package:todo_app/views/tasks/components/slider_drawer.dart';
import 'package:todo_app/views/tasks/widgets/task_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<SliderDrawerState> _drawerKey =
      GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FAB(),
      body: SliderDrawer(
        // to connect the icon with the drawer
        key: _drawerKey,
        // to hide the weird appbar at the top
        appBar: const SizedBox.shrink(),
        slider: CustomDrawer(),
        child: Column(
          children: [
            HomeAppBar(drawerKey: _drawerKey),
            const Expanded(child: TaskView()),
          ],
        ),
      ),
    );
  }
}
