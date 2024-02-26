import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/task_detail_screen.dart';
import 'providers/task_provider.dart';
import 'models/task.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter()); // Register the adapter
  await Hive.openBox<Task>('tasks'); // Open the 'tasks' box
  runApp(MyTodoApp());
}


class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => HomeScreen(),
          '/add-task': (ctx) => AddTaskScreen(),
          '/task-detail': (ctx) {
            final Map<String, dynamic> args = ModalRoute.of(ctx)!.settings.arguments as Map<String, dynamic>;
            final String taskId = args['taskId'];
            return TaskDetailScreen(taskId: taskId);
          },
        },
      ),
    );
  }
}
