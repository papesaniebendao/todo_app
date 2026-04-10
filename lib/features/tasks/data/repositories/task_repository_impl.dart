// lib/features/tasks/data/repositories/task_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDatasource datasource;

  TaskRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    try {
      final tasks = await datasource.getTasks();
      return Right(tasks); // succès → Right
    } catch (e) {
      return Left(CacheFailure()); // erreur → Left
    }
  }

  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) async {
    try {
      // On récupère la liste actuelle
      final currentTasks = await datasource.getTasks();

      // On convertit l'Entity en Model avant de sauvegarder
      final newTask = TaskModel(
        id: task.id,
        title: task.title,
        isDone: task.isDone,
      );

      final updatedTasks = [...currentTasks, newTask];
      await datasource.saveTasks(updatedTasks);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      final currentTasks = await datasource.getTasks();
      final updatedTasks = currentTasks.where((t) => t.id != id).toList();
      await datasource.saveTasks(updatedTasks);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
