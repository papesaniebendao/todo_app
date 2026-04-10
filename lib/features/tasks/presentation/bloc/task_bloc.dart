// lib/features/tasks/presentation/bloc/task_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final DeleteTask deleteTask;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.deleteTask,
  }) : super(const TaskInitial()) {
    // Chaque Event a son handler déclaré ici
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(const TaskLoading()); // 1. on signale le chargement

    final result = await getTasks(NoParams()); // 2. on appelle le UseCase

    // 3. Either : Left = erreur, Right = succès
    result.fold(
      (failure) =>
          emit(const TaskError(message: 'Impossible de charger les tâches')),
      (tasks) => emit(TaskLoaded(tasks: tasks)),
    );
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    final result = await addTask(AddTaskParams(task: event.task));

    result.fold(
      (failure) =>
          emit(const TaskError(message: 'Impossible d\'ajouter la tâche')),
      (_) => add(const LoadTasksEvent()), // on recharge la liste
    );
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final result = await deleteTask(DeleteTaskParams(id: event.id));

    result.fold(
      (failure) =>
          emit(const TaskError(message: 'Impossible de supprimer la tâche')),
      (_) => add(const LoadTasksEvent()), // on recharge la liste
    );
  }
}
