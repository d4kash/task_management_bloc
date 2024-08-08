import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_bloc/models/task.dart';
import 'package:task_management_bloc/repository/task_repository.dart';
import 'cubit/task_cubit.dart';
import 'screens/task_list_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/edit_task_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final taskRepository = TaskRepository();

  runApp(MyApp(taskRepository: taskRepository));
}

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository;

  const MyApp({super.key, required this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit(taskRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Task Management App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TaskListScreen(),
        routes: {
          '/addTask': (context) => const AddTaskScreen(),
          '/editTask': (context) {
            final task = ModalRoute.of(context)!.settings.arguments as Task;
            return EditTaskScreen(task: task);
          },
        },
      ),
    );
  }
}
