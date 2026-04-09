// lib/features/tasks/domain/repositories/task_repository.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks();
  Future<Either<Failure, void>> addTask(TaskEntity task);
  Future<Either<Failure, void>> deleteTask(String id);
}
