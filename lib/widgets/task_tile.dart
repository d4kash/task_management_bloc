import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  final VoidCallback onCompleteToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskWidget({
    super.key,
    required this.task,
    required this.onCompleteToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final dateFormat = DateFormat.yMMMMd(); // Format for date display

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: width < 400 ? 8.0 : 16.0,
        ),
        title: Text(
          widget.task.title,
          style: TextStyle(
            fontSize: width < 400 ? 16.0 : 18.0,
            fontWeight: FontWeight.bold,
            decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4.0),
            Text(
              widget.task.description,
              style: TextStyle(
                color: Colors.grey[600],
                decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Due: ${dateFormat.format(widget.task.dueDate)}',
              style: TextStyle(
                color: widget.task.isCompleted ? Colors.grey : Colors.redAccent,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                widget.task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                color: widget.task.isCompleted ? Colors.green : Colors.grey,
              ),
              onPressed: widget.onCompleteToggle,
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: widget.onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
