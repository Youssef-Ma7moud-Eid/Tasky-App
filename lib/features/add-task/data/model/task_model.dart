// class TaskModel {
//   String? title;
//   String? description;
//   String? id;
//   bool isCompleted;
//   int? priority;
//   DateTime? dateTime;

//   TaskModel({
//     this.title,
//     this.description,
//     this.isCompleted = false,
//     this.priority,
//     this.dateTime,
//     this.id,
//   });

//   TaskModel.fromJson(Map<String, dynamic> json)
//     : title = json['title'] as String?,
//       id = json['id'] as String?,
//       description = json['description'] as String?,
//       isCompleted = json['isCompleted'] as bool? ?? false,
//       priority = json['priority'] as int?,
//       dateTime = json['dateTime'] != null
//           ? DateTime.fromMillisecondsSinceEpoch(json['dateTime'] as int)
//           : null;

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'isCompleted': isCompleted,
//       'priority': priority,
//       'dateTime': dateTime?.millisecondsSinceEpoch,
//     };
//   }
// }
import 'package:isar/isar.dart';

part 'task_model.g.dart';

@collection
class TaskModel {
   String? title;
   String? description;
   bool isCompleted = false;
   int? priority;
   DateTime? dateTime;
   Id id = Isar.autoIncrement;

  TaskModel({
    required this.title,
    required this.description,
    required this.priority,
    required this.dateTime,
  });
}
