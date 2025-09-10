import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';

class TaskFirebaseOperation {
  static final uid = FirebaseAuth.instance.currentUser!.uid;

  static CollectionReference<TaskModel> taskRef = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('tasks')
      .withConverter<TaskModel>(
        fromFirestore: (snap, _) => TaskModel.fromJson(snap.data()!),
        toFirestore: (task, _) => task.toJson(),
      );

  static Future<void> addTask(TaskModel task) async {
    DocumentReference<TaskModel> docRef = taskRef.doc();

    task.id = docRef.id;

    await docRef.set(task);
  }

  static Stream<List<TaskModel>> getAllTasks() {
    return taskRef
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  static Future<void> updateTask(String taskId, TaskModel task) async {
    await taskRef.doc(taskId).set(task);
  }

  static Future<void> deleteTask(String taskId) async {
    await taskRef.doc(taskId).delete();
  }

  static Stream<List<TaskModel>> getTasksForDay(DateTime day) {
    final startOfDay = DateTime(day.year, day.month, day.day);

    final endOfDay = startOfDay.add(const Duration(days: 1));

    return taskRef
        .where(
          'dateTime',
          isGreaterThanOrEqualTo: startOfDay.millisecondsSinceEpoch,
        )
        .where('dateTime', isLessThan: endOfDay.millisecondsSinceEpoch)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  static Stream<List<TaskModel>> getTodayTasks() {
    return getTasksForDay(DateTime.now());
  }

  static Stream<List<TaskModel>> getTomorrowTasks() {
    return getTasksForDay(DateTime.now().add(const Duration(days: 1)));
  }

  static Stream<List<TaskModel>> searchTasks(String query, String filter) {
    final lowercaseQuery = query.toLowerCase();
    if (query.trim().isEmpty) {
      if (filter == "All") {
        return getAllTasks();
      } else if (filter == "Today") {
        return getTodayTasks();
      } else {
        return getTomorrowTasks();
      }
    }

    return taskRef.orderBy('dateTime', descending: true).snapshots().map((
      snapshot,
    ) {
      // Convert all docs to TaskModel
      final tasks = snapshot.docs.map((doc) => doc.data()).toList();

      // 🔹 Apply search filter
      var filtered = tasks.where((task) {
        final title = task.title?.toLowerCase() ?? '';
        final description = task.description?.toLowerCase() ?? '';
        return query.trim().isEmpty ||
            title.contains(lowercaseQuery) ||
            description.contains(lowercaseQuery);
      }).toList();

      if (filter == "Today") {
        final today = DateTime.now();
        filtered = filtered.where((task) {
          final taskDate = DateTime.now();
          return taskDate.year == today.year &&
              taskDate.month == today.month &&
              taskDate.day == today.day;
        }).toList();
      } else if (filter == "Tomorrow") {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        filtered = filtered.where((task) {
          final taskDate = task.dateTime ?? DateTime.now();
          return taskDate.year == tomorrow.year &&
              taskDate.month == tomorrow.month &&
              taskDate.day == tomorrow.day;
        }).toList();
      }

      return filtered;
    });
  }
}
