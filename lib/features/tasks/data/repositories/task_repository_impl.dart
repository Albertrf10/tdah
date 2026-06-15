import 'package:tdah_app/features/tasks/domain/entities/task.dart';
import 'package:tdah_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:tdah_app/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:tdah_app/features/tasks/data/models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<Task>> watchPending(String userId) {
    return remoteDataSource.watchPending(userId).map(
          (models) => models.map((m) => m.toEntity()).toList(),
    );
  }

  @override
  Stream<List<Task>> watchCompleted(String userId) {
    return remoteDataSource.watchCompleted(userId).map(
          (models) => models.map((m) => m.toEntity()).toList(),
    );
  }

  @override
  Future<void> create(Task task) async {
    await remoteDataSource.create(TaskModel.fromEntity(task));
  }

  @override
  Future<void> complete(String taskId) async {
    await remoteDataSource.complete(taskId);
  }
}
