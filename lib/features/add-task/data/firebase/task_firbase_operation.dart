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

  static Stream<List<TaskModel>> searchTasks(String query) {
    final lowercaseQuery = query.toLowerCase();
    if (query.trim().isEmpty) {
      return getAllTasks();
    }

    return taskRef.orderBy('dateTime', descending: true).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) => doc.data()).where((task) {
        final title = task.title?.toLowerCase() ?? '';
        final description = task.description?.toLowerCase() ?? '';
        return title.contains(lowercaseQuery) ||
            description.contains(lowercaseQuery);
      }).toList();
    });
  }
}
