class TodoItem {
  int? id;
  String title;
  String? description;
  bool completed;
  DateTime createdDate;
  DateTime expectedCompletionDate;
  bool pinned;
  int priority;
  DateTime? completionDate;
  bool isArchived; // deleted

  TodoItem({
    this.id,
    required this.title,
    this.description,
    this.completed = false,
    required this.expectedCompletionDate,
    required this.createdDate,
    this.pinned = false,
    this.priority = 1,
    this.completionDate,
    this.isArchived = false,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
      createdDate: DateTime.parse(json['created_date']),
      expectedCompletionDate: DateTime.parse(json['expected_completion_date']),
      pinned: json['pinned'],
      priority: json['priority'],
      completionDate: DateTime.parse(json['completion_date']),
      isArchived: json['is_archived'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'completed': completed,
        'created_date': createdDate.toIso8601String(),
        'expected_completion_date': expectedCompletionDate.toIso8601String(),
        'pinned': pinned,
        'priority': priority,
        'completion_date': completionDate?.toIso8601String(),
        'is_archived': isArchived,
      };
}
