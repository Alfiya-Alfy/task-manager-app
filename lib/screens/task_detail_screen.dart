import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  const TaskDetailsScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Task ID: ${task.id}'),
            Text('User ID: ${task.userId}'),
            Text('Title: ${task.title}'),
            Text(
              'Status: ${task.completed ? "Completed" : "Pending"}',
            ),
          ],
        ),
      ),
    );
  }
}