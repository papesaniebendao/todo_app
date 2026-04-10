// lib/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/tasks/data/datasources/task_local_datasource.dart';
import 'features/tasks/data/repositories/task_repository_impl.dart';
import 'features/tasks/domain/repositories/task_repository.dart';
import 'features/tasks/domain/usecases/add_task.dart';
import 'features/tasks/domain/usecases/delete_task.dart';
import 'features/tasks/domain/usecases/get_tasks.dart';

final sl = GetIt.instance; // "sl" = service locator

Future<void> init() async {
  // ── UseCases ──────────────────────────────────────────
  // registerFactory = nouvelle instance à chaque appel
  sl.registerFactory(() => GetTasks(sl()));
  sl.registerFactory(() => AddTask(sl()));
  sl.registerFactory(() => DeleteTask(sl()));

  // ── Repository ────────────────────────────────────────
  // registerLazySingleton = une seule instance, créée à la première demande
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(datasource: sl()),
  );

  // ── DataSources ───────────────────────────────────────
  sl.registerLazySingleton<TaskLocalDatasource>(
    () => TaskLocalDatasourceImpl(sharedPreferences: sl()),
  );

  // ── Externe (SharedPreferences) ───────────────────────
  // registerSingleton = instance créée immédiatement et réutilisée
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
}
