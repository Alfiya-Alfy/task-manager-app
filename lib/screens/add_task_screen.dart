import 'package:flutter/material.dart';
import '../models/task_model.dart';


class AddTaskScreen extends StatefulWidget {
  final Task? task;

  const AddTaskScreen({
    super.key,
    this.task,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  bool completed = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      titleController.text = widget.task!.title;
      completed = widget.task!.completed;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void saveTask() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final task = Task(
      id: widget.task?.id ??
          DateTime.now().millisecondsSinceEpoch,
      userId: 1,
      title: titleController.text,
      completed: completed,
      isLocal: true,
    );

    Navigator.pop(context, task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task == null
              ? 'Add Task'
              : 'Edit Task',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Title required';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title:
                    const Text('Completed Status'),
                value: completed,
                onChanged: (value) {
                  setState(() {
                    completed = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: saveTask,
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}