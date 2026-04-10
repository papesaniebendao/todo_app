// lib/core/usecases/usecase.dart

import 'package:dartz/dartz.dart';
import '../error/failures.dart';

// Type générique : Type = ce que retourne le usecase, Params = ses paramètres
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Quand un UseCase n'a pas besoin de paramètres
class NoParams {}
