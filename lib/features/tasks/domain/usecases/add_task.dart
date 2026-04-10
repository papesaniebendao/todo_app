// lib/features/tasks/domain/usecases/add_task.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class AddTask implements UseCase<void, AddTaskParams> {
  final TaskRepository repository;

  AddTask(this.repository);

  @override
  Future<Either<Failure, void>> call(AddTaskParams params) {
    return repository.addTask(params.task);
  }
}

// Les paramètres encapsulés dans leur propre classe
class AddTaskParams extends Equatable {
  final TaskEntity task;

  const AddTaskParams({required this.task});

  @override
  List<Object?> get props => [task];
}
