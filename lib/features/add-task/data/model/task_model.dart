
class TaskModel {
  String? title;
  String? description;
  bool isCompleted;
  int? priority;
  DateTime? dateTime;

  TaskModel({
    this.title,
    this.description,
    this.isCompleted = false,
    this.priority,
    this.dateTime,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
    : title = json['title'] as String?,
      description = json['description'] as String?,
      isCompleted = json['isCompleted'] as bool? ?? false,
      priority = json['priority'] as int?,
      dateTime = json['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['dateTime'] as int)
          : null;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'priority': priority,
      'dateTime': dateTime?.millisecondsSinceEpoch,
    };
  }
 
}
