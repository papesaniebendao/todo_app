// lib/features/tasks/presentation/bloc/task_event.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

// L'utilisateur ouvre l'écran → charger les tâches
class LoadTasksEvent extends TaskEvent {
  const LoadTasksEvent();
}

// L'utilisateur ajoute une tâche
class AddTaskEvent extends TaskEvent {
  final TaskEntity task;

  const AddTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

// L'utilisateur supprime une tâche
class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
