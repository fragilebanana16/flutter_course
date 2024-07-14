class TodoItem {
  final DateTime dueDate;
  bool completed;
  String title;
  String description;
  DateTime expectedCompletionDate;
  bool pinned;
  int priority; // 假设优先级从1到10，数字越小优先级越高
  int editCount;
  DateTime completionDate;
  bool isArchived;

  TodoItem({
    required this.dueDate,
    this.completed = false,
    required this.title,
    required this.description,
    required this.expectedCompletionDate,
    this.pinned = false,
    this.priority = 1,
    this.editCount = 0,
    required this.completionDate,
    this.isArchived = false,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      dueDate: DateTime.parse(json['due_date']),
      completed: json['completed'],
      title: json['title'],
      description: json['description'],
      expectedCompletionDate: DateTime.parse(json['expected_completion_date']),
      pinned: json['pinned'],
      priority: json['priority'],
      editCount: json['edit_count'],
      completionDate: DateTime.parse(json['completion_date']),
      isArchived: json['is_archived'],
    );
  }

  Map<String, dynamic> toJson() => {
        'due_date': dueDate.toIso8601String(),
        'completed': completed,
        'title': title,
        'description': description,
        'expected_completion_date': expectedCompletionDate.toIso8601String(),
        'pinned': pinned,
        'priority': priority,
        'edit_count': editCount,
        'completion_date': completionDate.toIso8601String(),
        'is_archived': isArchived,
      };
}
