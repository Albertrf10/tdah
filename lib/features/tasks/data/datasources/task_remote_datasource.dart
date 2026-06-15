import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Stream<List<TaskModel>> watchPending(String userId);
  
  Stream<List<TaskModel>> watchCompleted(String userId);

  Future<void> create(TaskModel task);

  Future<void> complete(String taskId);
}
