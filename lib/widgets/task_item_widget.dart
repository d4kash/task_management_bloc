import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final void Function(Task) onToggleComplete;
  final void Function(Task) onDelete;

  const TaskItemWidget({super.key, 
    required this.task,
    required this.onToggleComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text('Due: ${task.dueDate}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onDelete(task),
      ),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) => onToggleComplete(task),
      ),
      onTap: () => onToggleComplete(task),
    );
  }
}
