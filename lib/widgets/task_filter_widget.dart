import 'package:flutter/material.dart';

class TaskFilterWidget extends StatelessWidget {
  final String filter;
  final ValueChanged<String> onFilterChanged;

  const TaskFilterWidget({super.key, 
    required this.filter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onFilterChanged,
      itemBuilder: (context) {
        return ['all', 'completed', 'incomplete'].map((filter) {
          return PopupMenuItem<String>(
            value: filter,
            child: Text('Show $filter tasks'),
          );
        }).toList();
      },
    );
  }
}
