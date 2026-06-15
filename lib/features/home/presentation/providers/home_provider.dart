import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdah_app/features/tasks/presentation/providers/task_providers.dart';
import 'package:tdah_app/features/home/domain/entities/home_state.dart';

final homeStateProvider = Provider<AsyncValue<HomeStateData>>((ref) {
  final pendingAsync = ref.watch(pendingTasksProvider);
  final completedAsync = ref.watch(completedTasksProvider);

  if (pendingAsync.isLoading || completedAsync.isLoading) {
    return const AsyncValue.loading();
  }

  if (pendingAsync.hasError) {
    return AsyncValue.error(
      pendingAsync.error ?? 'Error desconocido en tareas pendientes', 
      pendingAsync.stackTrace ?? StackTrace.current
    );
  }
  if (completedAsync.hasError) {
    return AsyncValue.error(
      completedAsync.error ?? 'Error desconocido en tareas completadas', 
      completedAsync.stackTrace ?? StackTrace.current
    );
  }

  final pending = pendingAsync.value ?? [];
  final completed = completedAsync.value ?? [];
  final now = DateTime.now();

  final activeTasks = pending.where((task) {
    final scheduledAt = task.scheduledAt;
    if (scheduledAt == null) return true;
    return scheduledAt.isBefore(now) || scheduledAt.isAtSameMomentAs(now);
  }).toList();

  final inactiveTasks = pending.where((task) {
    final scheduledAt = task.scheduledAt;
    if (scheduledAt == null) return false;
    return scheduledAt.isAfter(now);
  }).toList();

  final sortedActive = List.of(activeTasks)..sort((a, b) => a.position.compareTo(b.position));

  return AsyncValue.data(HomeStateData(
    currentTask: sortedActive.isNotEmpty ? sortedActive.first : null,
    nextTask: sortedActive.length > 1 ? sortedActive[1] : null,
    completedTasks: completed.length,
    totalTasks: pending.length + completed.length,
    activeTasksCount: activeTasks.length,
    inactiveTasksCount: inactiveTasks.length,
  ));
});
