import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_bloc/repository/task_repository.dart';
import '../models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _taskRepository;

   TaskCubit(this._taskRepository) : super(TaskState(tasks: [], // Initialize tasks list
          filteredTasks: [], // Initialize filteredTasks list
          error: '' // Initialize error string
          )) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      final tasks = await _taskRepository.fetchTasks();
      emit(state.copyWith(tasks: tasks, filteredTasks: tasks));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _taskRepository.insertTask(task);
      final newTasks = [task, ...state.tasks];
      emit(state.copyWith(tasks: newTasks, filteredTasks: newTasks));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _taskRepository.updateTask(task);
      loadTasks(); // Reload tasks to reflect changes
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _taskRepository.deleteTask(id);
      loadTasks(); // Reload tasks to reflect deletion
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

Future<void> toggleTaskComplete(Task task) async {
    try {
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      await _taskRepository.updateTask(updatedTask);
      loadTasks(); // Refresh task list after toggling completion status
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void filterTasks(bool? showCompleted) {
    if (showCompleted == null) {
      // Show all tasks
      emit(state.copyWith(filteredTasks: state.tasks));
    } else {
      final filteredTasks = state.tasks
          .where((task) => task.isCompleted == showCompleted)
          .toList();
      emit(state.copyWith(filteredTasks: filteredTasks));
    }
  }

  void sortTasksByDueDate(bool ascending) {
    final sortedTasks = List<Task>.from(state.filteredTasks)
      ..sort((a, b) => ascending
          ? a.dueDate.compareTo(b.dueDate)
          : b.dueDate.compareTo(a.dueDate));
    emit(state.copyWith(filteredTasks: sortedTasks));
  }
}
