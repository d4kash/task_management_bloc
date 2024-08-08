import 'package:flutter/material.dart';

class TaskSortWidget extends StatelessWidget {
  final String sortOption;
  final ValueChanged<String> onSortChanged;

  const TaskSortWidget({super.key, 
    required this.sortOption,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSortChanged,
      itemBuilder: (context) {
        return ['dueDateAsc', 'dueDateDesc'].map((option) {
          return PopupMenuItem<String>(
            value: option,
            child: Text('Sort by due date ${option == 'dueDateAsc' ? 'ascending' : 'descending'}'),
          );
        }).toList();
      },
    );
  }
}
