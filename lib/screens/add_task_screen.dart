import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_bloc/cubit/task_cubit.dart';
import 'package:task_management_bloc/widgets/common_form.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskForm(
          onSave: (newTask) {
            BlocProvider.of<TaskCubit>(context).addTask(newTask);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
