import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class ApiService {
  static const String url =
      'https://jsonplaceholder.typicode.com/todos';

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data
          .map((e) => Task.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}