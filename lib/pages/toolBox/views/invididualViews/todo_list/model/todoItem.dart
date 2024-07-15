class TodoItem {
  int? id;
  String title;
  String? description;
  // final DateTime dueDate;
  // bool completed;
  // DateTime expectedCompletionDate;
  // bool pinned;
  // int priority;
  // int editCount;
  // DateTime? completionDate;
  // bool isArchived;

  TodoItem({
    this.id,
    required this.title,
    this.description,
    // required this.dueDate,
    // this.completed = false,

    // required this.expectedCompletionDate,
    // this.pinned = false,
    // this.priority = 1,
    // this.editCount = 0,
    // this.completionDate,
    // this.isArchived = false,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      title: json['title'],
      description: json['description'],
      // dueDate: DateTime.parse(json['due_date']),
      // completed: json['completed'],
      // expectedCompletionDate: DateTime.parse(json['expected_completion_date']),
      // pinned: json['pinned'],
      // priority: json['priority'],
      // editCount: json['edit_count'],
      // completionDate: DateTime.parse(json['completion_date']),
      // isArchived: json['is_archived'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        // 'due_date': dueDate.toIso8601String(),
        // 'completed': completed,
        // 'expected_completion_date': expectedCompletionDate.toIso8601String(),
        // 'pinned': pinned,
        // 'priority': priority,
        // 'edit_count': editCount,
        // 'completion_date': completionDate?.toIso8601String(),
        // 'is_archived': isArchived,
      };
}
