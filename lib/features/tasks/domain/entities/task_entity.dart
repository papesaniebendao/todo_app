// lib/features/tasks/domain/entities/task_entity.dart

import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final bool isDone;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.isDone,
  });

  @override
  List<Object?> get props => [id, title, isDone];
}
