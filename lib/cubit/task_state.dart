part of 'task_cubit.dart';

enum TaskStatus { initial, loading, success, failure }
enum SortOrder { ascending, descending }

class TaskState {
  final List<Task> tasks;
  final List<Task> filteredTasks;
  final String error;

  TaskState({
    required this.tasks,
    required this.filteredTasks,
    required this.error,
  });

  factory TaskState.initial() {
    return TaskState(
      tasks: [],
      filteredTasks: [],
      error: '',
    );
  }

  TaskState copyWith({
    List<Task>? tasks,
    List<Task>? filteredTasks,
    String? error,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      error: error ?? this.error,
    );
  }
}
