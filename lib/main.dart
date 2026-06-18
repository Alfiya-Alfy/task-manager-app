import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('dark_theme') ?? false;

  runApp(TaskManagerApp(isDark: isDark));
}

class TaskManagerApp extends StatefulWidget {
  final bool isDark;

  const TaskManagerApp({
    super.key,
    required this.isDark,
  });

  static _TaskManagerAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_TaskManagerAppState>();
  }

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  late bool isDark;

  @override
  void initState() {
    super.initState();
    isDark = widget.isDark;
  }

  Future<void> toggleTheme() async {
    setState(() {
      isDark = !isDark;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_theme', isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const TaskListScreen(),
    );
  }
}