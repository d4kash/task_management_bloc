import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:task_management_bloc/widgets/task_tile.dart';
import '../cubit/task_cubit.dart';
import '../models/task.dart';
import 'route_transitions.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Sort Ascending') {
                context.read<TaskCubit>().sortTasksByDueDate(true);
              } else if (value == 'Sort Descending') {
                context.read<TaskCubit>().sortTasksByDueDate(false);
              } else if (value == 'Show Completed') {
                context.read<TaskCubit>().filterTasks(true);
              } else if (value == 'Show Incomplete') {
                context.read<TaskCubit>().filterTasks(false);
              } else if (value == 'Show All') {
                context.read<TaskCubit>().filterTasks(null);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: 'Sort Ascending', child: Text('Sort Ascending')),
                const PopupMenuItem(value: 'Sort Descending', child: Text('Sort Descending')),
                const PopupMenuItem(value: 'Show Completed', child: Text('Show Completed')),
                const PopupMenuItem(value: 'Show Incomplete', child: Text('Show Incomplete')),
                const PopupMenuItem(value: 'Show All', child: Text('Show All')),
              ];
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state.filteredTasks.isEmpty) {
            return const Center(child: Text('No tasks available'));
          }

          return AnimatedList(
            key: GlobalKey<AnimatedListState>(),
            initialItemCount: state.filteredTasks.length,
            itemBuilder: (context, index, animation) {
              final task = state.filteredTasks[index];

              return SlideTransition(
                position: animation.drive(Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOut))),
                child: TaskWidget(
                  task: task,
                  onCompleteToggle: () {
                    context.read<TaskCubit>().updateTask(
                          task.copyWith(isCompleted: !task.isCompleted),
                        );
                  },
                  onEdit: () {
                    Navigator.of(context).push(
                      SlideTransitionPageRoute(
                        page: EditTaskScreen(task: task),
                      ),
                    );
                  },
                  onDelete: () {
                    context.read<TaskCubit>().deleteTask(task.id!);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            SlideTransitionPageRoute(page: const AddTaskScreen()),
          );

          if (result is Task) {
            // ignore: use_build_context_synchronously
            context.read<TaskCubit>().addTask(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
