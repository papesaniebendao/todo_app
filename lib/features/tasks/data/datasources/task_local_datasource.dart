// lib/features/tasks/data/datasources/task_local_datasource.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

// L'interface (bonne pratique : toujours définir un abstract)
abstract class TaskLocalDatasource {
  Future<List<TaskModel>> getTasks();
  Future<void> saveTasks(List<TaskModel> tasks);
}

// L'implémentation concrète
class TaskLocalDatasourceImpl implements TaskLocalDatasource {
  final SharedPreferences sharedPreferences;

  // La clé de stockage dans SharedPreferences
  static const _cachedTasksKey = 'CACHED_TASKS';

  TaskLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<List<TaskModel>> getTasks() async {
    final jsonString = sharedPreferences.getString(_cachedTasksKey);

    if (jsonString == null) {
      return []; // Aucune tâche sauvegardée → liste vide
    }

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((jsonItem) => TaskModel.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveTasks(List<TaskModel> tasks) async {
    final jsonString = json.encode(tasks.map((task) => task.toJson()).toList());
    await sharedPreferences.setString(_cachedTasksKey, jsonString);
  }
}
