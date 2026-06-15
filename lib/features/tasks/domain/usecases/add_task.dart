import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/domain/repositories/task_repository.dart';

class AddTask {
  final TaskRepository repo;

  AddTask(this.repo);

  Future<void> call(Task task) {
    return repo.create(task);
  }
}