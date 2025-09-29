import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/utils/local_notification_services.dart';
import 'package:tasky/features/add-task/data/firebase/task_firbase_operation.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';

class TaskLocalDatabaseOperation {
  static late final Isar db;

  /// Setup database
  static Future<void> setup() async {
    final dir = await getApplicationDocumentsDirectory();
    db = await Isar.open([TaskModelSchema], directory: dir.path);
  }

  /// Add Task
  static Future<void> addTask(TaskModel task) async {
    await db.writeTxn(() async {
      final id = await db.taskModels.put(task);
      task.id = id;
    });

    final notificationId = generateStableId(task.id.toString());
    LoalNotificationServices.showScheduledNotification(notificationId, task);
  }

  /// Update Task
  static Future<void> updateTask(TaskModel task) async {
    final notificationId = generateStableId(task.id.toString());
    LoalNotificationServices.cancelNotifications(notificationId);

    if (!task.isCompleted &&
        task.dateTime != null &&
        task.dateTime!.isAfter(DateTime.now())) {
      LoalNotificationServices.showScheduledNotification(notificationId, task);
    }
    

    await db.writeTxn(() async {
      await db.taskModels.put(task);
    });
  }

  /// Delete Task
  static Future<void> deleteTask(int taskId) async {
    final notificationId = generateStableId(taskId.toString());
    LoalNotificationServices.cancelNotifications(notificationId);

    await db.writeTxn(() async {
      await db.taskModels.delete(taskId);
    });
  }

  /// Get tasks for a specific day
  static Stream<List<TaskModel>> getTasksForDay(DateTime day) {
    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return db.taskModels
        .filter()
        .dateTimeBetween(startOfDay, endOfDay)
        .sortByDateTime()
        .watch(fireImmediately: true);
  }

  /// Get today's tasks
  static Stream<List<TaskModel>> getTodayTasks() {
    return getTasksForDay(DateTime.now());
  }

  /// Get tomorrow's tasks
  static Stream<List<TaskModel>> getTomorrowTasks() {
    return getTasksForDay(DateTime.now().add(const Duration(days: 1)));
  }

  /// Get all tasks
  static Stream<List<TaskModel>> getAllTasks() {
    return db.taskModels.where().sortByDateTime().watch(fireImmediately: true);
  }

  /// Search tasks by name and filter (Today, Tomorrow, or All)
  static Stream<List<TaskModel>> searchTasks(String name, String filter) {
    final lowercaseQuery = name.toLowerCase().trim();

    DateTime? startOfDay;
    DateTime? endOfDay;

    if (filter == "Today" || filter == "Tomorrow") {
      final baseDay = filter == "Today"
          ? DateTime.now()
          : DateTime.now().add(const Duration(days: 1));

      startOfDay = DateTime(baseDay.year, baseDay.month, baseDay.day);
      endOfDay = startOfDay.add(const Duration(days: 1));
    }

    final query = (startOfDay != null && endOfDay != null)
        ? db.taskModels.filter().dateTimeBetween(startOfDay, endOfDay)
        : db.taskModels.filter().dateTimeEqualTo(startOfDay);

    return query.watch(fireImmediately: true).map((tasks) {
      if (lowercaseQuery.isEmpty) return tasks;

      return tasks.where((task) {
        final title = task.title?.toLowerCase() ?? '';
        final description = task.description?.toLowerCase() ?? '';
        return title.contains(lowercaseQuery) ||
            description.contains(lowercaseQuery);
      }).toList();
    });
  }
}
