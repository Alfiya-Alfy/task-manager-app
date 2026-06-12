import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import 'task_detail_screen.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final ApiService apiService = ApiService();
  final StorageService storageService = StorageService();

  List<Task> allTasks = [];
  List<Task> filteredTasks = [];

  bool isLoading = true;
  bool hasError = false;

  String searchText = '';
  String filter = 'All';

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final apiTasks = await apiService.fetchTasks();
      final localTasks = await storageService.loadTasks();

      allTasks = [...localTasks, ...apiTasks];

      applyFilters();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  void applyFilters() {
    List<Task> result = allTasks;

    if (filter == 'Completed') {
      result =
          result.where((task) => task.completed).toList();
    }

    if (filter == 'Pending') {
      result =
          result.where((task) => !task.completed).toList();
    }

    if (searchText.isNotEmpty) {
      result = result.where((task) {
        return task.title
            .toLowerCase()
            .contains(searchText.toLowerCase());
      }).toList();
    }

    filteredTasks = result;
  }

  Future<void> addTask() async {
    final task = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddTaskScreen(),
      ),
    );

    if (task != null && task is Task) {
      allTasks.insert(0, task);

      final localTasks =
          allTasks.where((e) => e.isLocal).toList();

      await storageService.saveTasks(localTasks);

      applyFilters();

      setState(() {});
    }
  }

  Widget buildFilterButton(String value) {
    return ChoiceChip(
      label: Text(value),
      selected: filter == value,
      onSelected: (_) {
        setState(() {
          filter = value;
          applyFilters();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: loadTasks,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search tasks...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  searchText = value;
                  applyFilters();
                  setState(() {});
                },
              ),
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                buildFilterButton('All'),
                buildFilterButton('Completed'),
                buildFilterButton('Pending'),
              ],
            ),

            const SizedBox(height: 10),

            Expanded(
              child: isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(),
                    )
                  : hasError
                      ? Center(
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                            children: [
                              const Text(
                                'Failed to load tasks',
                              ),
                              ElevatedButton(
                                onPressed: loadTasks,
                                child:
                                    const Text('Retry'),
                              )
                            ],
                          ),
                        )
                      : filteredTasks.isEmpty
                          ? const Center(
                              child: Text(
                                  'No tasks found'),
                            )
                          : ListView.builder(
                              itemCount:
                                  filteredTasks.length,
                              itemBuilder:
                                  (context, index) {
                                final task =
                                    filteredTasks[index];

                                return Card(
                                  margin:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  child: ListTile(
                                    leading: Checkbox(
                                      value:
                                          task.completed,
                                      onChanged: null,
                                    ),
                                    title:
                                        Text(task.title),
                                    subtitle: Text(
                                      task.completed
                                          ? 'Completed'
                                          : 'Pending',
                                    ),
                                    trailing:
                                        const Icon(
                                      Icons
                                          .arrow_forward_ios,
                                      size: 16,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              TaskDetailsScreen(
                                            task: task,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}