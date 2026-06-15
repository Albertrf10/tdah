import 'package:tdah_app/features/tasks/domain/entities/task.dart';

abstract class TaskRepository {
  Stream<List<Task>> watchPending(String userId);
  
  Stream<List<Task>> watchCompleted(String userId);

  Future<void> create(Task task);

  Future<void> complete(String taskId);
}
