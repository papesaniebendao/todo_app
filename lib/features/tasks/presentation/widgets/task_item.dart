// lib/features/tasks/presentation/widgets/task_item.dart

import 'package:flutter/material.dart';
import '../../domain/entities/task_entity.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback onDelete;

  const TaskItem({super.key, required this.task, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        task.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
        color: task.isDone ? Colors.green : Colors.grey,
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}
