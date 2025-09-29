import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tasky/core/utils/local_notification_services.dart';
// import 'package:tasky/features/add-task/data/model/task_model.dart';

// class TaskFirebaseOperation {
//   static final uid = FirebaseAuth.instance.currentUser!.uid;

//   static CollectionReference<TaskModel> taskRef = FirebaseFirestore.instance
//       .collection('users')
//       .doc(uid)
//       .collection('tasks')
//       .withConverter<TaskModel>(
//         fromFirestore: (snap, _) => TaskModel.fromJson(snap.data()!),
//         toFirestore: (task, _) => task.toJson(),
//       );

//   static Future<void> addTask(TaskModel task) async {
//     DocumentReference<TaskModel> docRef = taskRef.doc();

//     task.id = docRef.id;
//     final notificationId = generateStableId(task.id!);
//     LoalNotificationServices.showScheduledNotification(notificationId, task);

//     await docRef.set(task);
//   }

//   static Stream<List<TaskModel>> getAllTasks() {
//     return taskRef
//         .orderBy('dateTime', descending: false)
//         .snapshots()
//         .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
//   }

//   static Future<void> updateTask(String taskId, TaskModel task) async {
//     final notificationId = generateStableId(task.id!);

//     LoalNotificationServices.cancelNotifications(notificationId);
//     if (task.isCompleted == false) {
//       LoalNotificationServices.showScheduledNotification(notificationId, task);
//     }
//     await taskRef.doc(taskId).set(task);
//   }

//   static Future<void> deleteTask(String taskId) async {
//     final notificationId = generateStableId(taskId);

//     LoalNotificationServices.cancelNotifications(notificationId);
//     await taskRef.doc(taskId).delete();
//   }

//   static Stream<List<TaskModel>> getTasksForDay(DateTime day) {
//     final startOfDay = DateTime(day.year, day.month, day.day);

//     final endOfDay = startOfDay.add(const Duration(days: 1));

//     return taskRef
//         .where(
//           'dateTime',
//           isGreaterThanOrEqualTo: startOfDay.millisecondsSinceEpoch,
//         )
//         .where('dateTime', isLessThan: endOfDay.millisecondsSinceEpoch)
//         .orderBy('dateTime', descending: false)
//         .snapshots()
//         .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
//   }

//   static Stream<List<TaskModel>> getTodayTasks() {
//     return getTasksForDay(DateTime.now());
//   }

//   static Stream<List<TaskModel>> getTomorrowTasks() {
//     return getTasksForDay(DateTime.now().add(const Duration(days: 1)));
//   }

//   static Stream<List<TaskModel>> searchTasks(String query, String filter) {
//     final lowercaseQuery = query.toLowerCase().trim();

//     Query<TaskModel> queryRef = taskRef.orderBy('dateTime', descending: false);

//     if (filter == "Today") {
//       final today = DateTime.now();
//       final startOfDay = DateTime(today.year, today.month, today.day);
//       final endOfDay = startOfDay.add(const Duration(days: 1));

//       queryRef = queryRef
//           .where(
//             'dateTime',
//             isGreaterThanOrEqualTo: startOfDay.millisecondsSinceEpoch,
//           )
//           .where('dateTime', isLessThan: endOfDay.millisecondsSinceEpoch);
//     } else if (filter == "Tomorrow") {
//       final tomorrow = DateTime.now().add(const Duration(days: 1));
//       final startOfDay = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
//       final endOfDay = startOfDay.add(const Duration(days: 1));

//       queryRef = queryRef
//           .where(
//             'dateTime',
//             isGreaterThanOrEqualTo: startOfDay.millisecondsSinceEpoch,
//           )
//           .where('dateTime', isLessThan: endOfDay.millisecondsSinceEpoch);
//     }

//     if (lowercaseQuery.isEmpty) {
//       return queryRef.snapshots().map(
//         (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
//       );
//     }

//     return queryRef.snapshots().map((snapshot) {
//       final tasks = snapshot.docs.map((doc) => doc.data()).toList();
//       return tasks.where((task) {
//         final title = task.title?.toLowerCase() ?? '';
//         final description = task.description?.toLowerCase() ?? '';
//         return title.contains(lowercaseQuery) ||
//             description.contains(lowercaseQuery);
//       }).toList();
//     });
//   }
// }

int generateStableId(String docId) {
  final bytes = utf8.encode(docId);
  final digest = md5.convert(bytes);

  // Take first 4 bytes → 32-bit int
  final value = int.parse(digest.toString().substring(0, 8), radix: 16);

  // Force it into signed 32-bit range
  return value & 0x7FFFFFFF; // max = 2147483647
}
