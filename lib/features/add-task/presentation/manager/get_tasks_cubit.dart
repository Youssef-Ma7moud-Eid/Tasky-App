import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/add-task/data/firebase/task_firbase_operation.dart';
import 'package:tasky/features/add-task/presentation/manager/get_tasks_state.dart';

class GetTasksCubit extends Cubit<GetTasksState> {
  GetTasksCubit() : super(TasksInitial());

  Future<void> getTasks() async {
    try {
      emit(TasksLoading());
      var taskList = await TaskFirebaseOperation.getAllTasks();
      if (taskList.isEmpty) {
        emit(TasksEmpty());
      } else {
        emit(TasksLoaded(tasks: taskList));
      }
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }
}
