import 'package:flutter/material.dart';
import '../models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() =>
      _AddTaskScreenState();
}

class _AddTaskScreenState
    extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController =
      TextEditingController();

  bool completed = false;

  void saveTask() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch,
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
      appBar:
          AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration:
                    const InputDecoration(
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
                title: const Text(
                    'Completed Status'),
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