import 'package:equatable/equatable.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';

abstract class GetTasksState extends Equatable {
  const GetTasksState();

  @override
  List<Object?> get props => [];
}
class TasksInitial extends GetTasksState {}
class TasksLoading extends GetTasksState {}

class TasksEmpty extends GetTasksState {}

class TasksLoaded extends GetTasksState {
  final List<TaskModel> tasks;

  const TasksLoaded({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}
class TasksError extends GetTasksState {
  final String message;

  const TasksError({required this.message});

  @override
  List<Object?> get props => [message];
}