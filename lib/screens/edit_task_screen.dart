import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_bloc/cubit/task_cubit.dart';
import 'package:task_management_bloc/models/task.dart';
import 'package:task_management_bloc/widgets/common_form.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskForm(
          task: task,
          onSave: (updatedTask) {
            BlocProvider.of<TaskCubit>(context).updateTask(updatedTask);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
