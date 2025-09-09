import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';

class TaskFirebaseOperation {
  final CollectionReference<TaskModel> tasksRef = FirebaseFirestore.instance
      .collection('tasks')
      .withConverter<TaskModel>(
        fromFirestore: (snap, _) => TaskModel.fromJson(snap.data()!),
        toFirestore: (task, _) => task.toJson(),
      );

  Future<void> addTask(TaskModel task) async {
    await tasksRef.add(task);
  }

  Future<List<TaskModel>> getAllTasks() async {
    final querySnapshot = await tasksRef.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> updateTask(String taskId, TaskModel task) async {
    await tasksRef.doc(taskId).set(task);
  }

  Future<void> deleteTask(String taskId) async {
    await tasksRef.doc(taskId).delete();
  }
}
