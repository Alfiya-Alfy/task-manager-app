import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskTile({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Checkbox(
        value: task.completed,
        onChanged: null,
      ),
      title: Text(task.title),
      subtitle: Text(
        task.completed
            ? 'Completed'
            : 'Pending',
      ),
    );
  }
}