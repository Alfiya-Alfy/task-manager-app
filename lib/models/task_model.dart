class Task {
  final int id;
  final int userId;
  final String title;
  bool completed;
  bool isLocal;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
    this.isLocal = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'completed': completed,
      'isLocal': isLocal,
    };
  }

  factory Task.fromLocalJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
      isLocal: json['isLocal'] ?? true,
    );
  }
}