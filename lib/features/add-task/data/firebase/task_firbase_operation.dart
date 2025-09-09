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

  static Future<List<TaskModel>> getAllTasks() async {
    final querySnapshot = await taskRef.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> updateTask(String taskId, TaskModel task) async {
    await taskRef.doc(taskId).set(task);
  }

  static Future<void> deleteTask(String taskId) async {
    await taskRef.doc(taskId).delete();
  }
}
