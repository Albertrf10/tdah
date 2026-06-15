import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/domain/repositories/task_repository.dart';

class GetNextTask {
  final TaskRepository repo;

  GetNextTask(this.repo);

  Stream<Task?> call(String userId) {
    return repo.watchPending(userId).map((tasks) {
      if (tasks.isEmpty) return null;

      // orden lógico TDAH: primero lo más urgente / posición más baja
      tasks.sort((a, b) => a.position.compareTo(b.position));

      return tasks.first;
    });
  }
}