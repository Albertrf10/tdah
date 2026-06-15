import '../../../tasks/domain/repositories/task_repository.dart';

class CompleteTask {
  final TaskRepository repo;

  CompleteTask(this.repo);

  Future<void> call(String taskId) {
    return repo.complete(taskId);
  }
}