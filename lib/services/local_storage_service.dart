import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class StorageService {
  static const String key = 'local_tasks';

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList =
        tasks.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, jsonList);
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final list = prefs.getStringList(key) ?? [];

    return list
        .map((e) =>
            Task.fromLocalJson(jsonDecode(e)))
        .toList();
  }
}