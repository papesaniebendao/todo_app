// lib/features/tasks/presentation/bloc/task_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/task_entity.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

// État initial, avant toute action
class TaskInitial extends TaskState {
  const TaskInitial();
}

// Chargement en cours → afficher un spinner
class TaskLoading extends TaskState {
  const TaskLoading();
}

// Données disponibles → afficher la liste
class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;

  const TaskLoaded({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

// Une erreur s'est produite → afficher un message
class TaskError extends TaskState {
  final String message;

  const TaskError({required this.message});

  @override
  List<Object?> get props => [message];
}
