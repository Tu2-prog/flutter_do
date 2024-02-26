import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';
import 'package:flutter_do/models/task.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return FutureBuilder<List<Task>>(
            future: taskProvider.tasks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final tasks = snapshot.data!;
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (ctx, index) {
                      final task = tasks[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/task-detail',
                            arguments: {'taskId': task.id},
                          );
                        },
                        child: TaskTile(
                          title: task.title,
                          isDone: task.isDone,
                          onChanged: (value) {
                            taskProvider.completeTask(task.id, !task.isDone);
                          },
                        ),
                      );
                    },
                  );
                }
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-task');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
