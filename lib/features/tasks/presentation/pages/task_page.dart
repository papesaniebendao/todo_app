// lib/features/tasks/presentation/pages/task_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task_entity.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../widgets/task_item.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    // On déclenche le chargement dès l'ouverture de la page
    context.read<TaskBloc>().add(const LoadTasksEvent());

    return Scaffold(
      appBar: AppBar(title: const Text('Mes tâches')),

      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskError) {
            return Center(child: Text(state.message));
          }

          if (state is TaskLoaded) {
            if (state.tasks.isEmpty) {
              return const Center(
                child: Text('Aucune tâche — ajoutes-en une !'),
              );
            }

            return ListView.separated(
              itemCount: state.tasks.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return TaskItem(
                  task: task,
                  onDelete: () => context.read<TaskBloc>().add(
                    DeleteTaskEvent(id: task.id),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nouvelle tâche'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Titre de la tâche'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) return;

              // On envoie l'Event au BLoC avec la nouvelle tâche
              context.read<TaskBloc>().add(
                AddTaskEvent(
                  task: TaskEntity(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: controller.text.trim(),
                    isDone: false,
                  ),
                ),
              );
              Navigator.pop(dialogContext);
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }
}
