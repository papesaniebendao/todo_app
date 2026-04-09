// lib/features/tasks/data/models/task_model.dart

import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.title,
    required super.isDone,
  });

  // Depuis un Map JSON (lecture depuis SharedPreferences)
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool,
    );
  }

  // Vers un Map JSON (écriture dans SharedPreferences)
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isDone': isDone};
  }

  // Pratique pour mettre à jour un champ sans tout réécrire
  TaskModel copyWith({String? id, String? title, bool? isDone}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
