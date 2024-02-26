import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;

  TaskDetailScreen({required this.taskId});

  @override
  Widget build(BuildContext context) {
    // Here, you would fetch task details based on the taskId
    // You can use FutureBuilder or any other asynchronous method for fetching data

    // For demonstration, let's assume you have a method to fetch task details
    // This is just a placeholder, replace it with your actual data fetching logic
    Future<Map<String, dynamic>> fetchTaskDetails(String taskId) async {
      // Simulated task details fetching
      // You should replace this with your actual data fetching logic
      return {
        'id': taskId,
        'title': 'Task $taskId',
        'description': 'Description of Task $taskId',
        // Add more fields as per your task details
      };
    }

    return FutureBuilder(
      future: fetchTaskDetails(taskId),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while fetching data
          return Scaffold(
            appBar: AppBar(
              title: Text('Task Details'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasError) {
            // Display an error message if data fetching fails
            return Scaffold(
              appBar: AppBar(
                title: Text('Task Details'),
              ),
              body: Center(
                child: Text('Error fetching task details'),
              ),
            );
          } else {
            // Once data is fetched successfully, display task details
            final taskDetails = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text('Task Details'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Task ID: ${taskDetails['id']}',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Text(
                      'Title: ${taskDetails['title']}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      'Description: ${taskDetails['description']}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    // Add more fields as per your task details
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
