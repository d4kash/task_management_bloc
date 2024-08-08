// import 'package:bloc/bloc.dart';
// import 'package:task_management_bloc/helpers/database_helper.dart';
// import '../models/task.dart';
// import 'task_sort.dart';

// enum TaskFilter { all, completed, incomplete }

// class TaskCubit extends Cubit<TaskState> {
//   final DatabaseHelper _databaseHelper = DatabaseHelper();
//   List<Task> _allTasks = []; // Keep track of all tasks

//   TaskCubit() : super(TaskInitial()) {
//     _loadTasks();
//   }

//   Future<void> _loadTasks() async {
//     try {
//       _allTasks = await _databaseHelper.getTasks();
//       emit(TaskListLoaded(_allTasks));
//     } catch (e) {
//       emit(TaskLoadFailed());
//     }
//   }

//   Future<void> addTask(Task task) async {
//     await _databaseHelper.insertTask(task);
//     _loadTasks();
//   }

//   Future<void> editTask(Task task) async {
//     await _databaseHelper.updateTask(task);
//     _loadTasks();
//   }

//   Future<void> removeTask(String id) async {
//     await _databaseHelper.deleteTask(id);
//     _loadTasks();
//   }

//   Future<void> toggleCompletion(int index) async {
//     final currentState = state;
//     if (currentState is TaskListLoaded) {
//       final task = currentState.tasks[index];
//       task.isCompleted = !task.isCompleted;
//       await _databaseHelper.updateTask(task);
//       _loadTasks();
//     }
//   }

//   void filterAndSortTasks(TaskFilter filter, TaskSort sort) {
//     List<Task> filteredTasks = _allTasks.toList(); // Use the original list for filtering

//     // Apply filtering
//     if (filter == TaskFilter.completed) {
//       filteredTasks = _allTasks.where((task) => task.isCompleted).toList();
//     } else if (filter == TaskFilter.incomplete) {
//       filteredTasks = _allTasks.where((task) => !task.isCompleted).toList();
//     }

//     // Apply sorting
//     switch (sort) {
//       case TaskSort.dueDateAsc:
//         filteredTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
//         break;
//       case TaskSort.dueDateDesc:
//         filteredTasks.sort((a, b) => b.dueDate.compareTo(a.dueDate));
//         break;
//       case TaskSort.titleAsc:
//         filteredTasks.sort((a, b) => a.title.compareTo(b.title));
//         break;
//       case TaskSort.titleDesc:
//         filteredTasks.sort((a, b) => b.title.compareTo(a.title));
//         break;
//     }

//     emit(TaskListLoaded(filteredTasks));
//   }
// }

// class TaskState {}

// class TaskInitial extends TaskState {}

// class TaskListLoaded extends TaskState {
//   final List<Task> tasks;

//   TaskListLoaded(this.tasks);
// }

// class TaskLoadFailed extends TaskState {}
