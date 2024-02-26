import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool isDone;
  final Function(bool?) onChanged;

  TaskTile({
    required this.title,
    required this.isDone,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adds shadow to the card
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Adds some margin around the card
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            decoration: isDone ? TextDecoration.lineThrough : null, // Add strikethrough if task is done
          ),
        ),
        leading: Checkbox(
          value: isDone,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
