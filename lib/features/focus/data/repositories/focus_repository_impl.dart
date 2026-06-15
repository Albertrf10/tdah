import '../../domain/repositories/focus_repository.dart';
import '../datasources/focus_remote_datasource.dart';
import '../models/focus_session_model.dart';

class FocusRepositoryImpl implements FocusRepository {
  final FocusRemoteDataSource remoteDataSource;

  FocusRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> saveFocusSession({
    required String taskId,
    required String userId,
    required DateTime startedAt,
    required DateTime endedAt,
    required int durationMinutes,
    required bool completed,
  }) async {
    final model = FocusSessionModel(
      userId: userId,
      taskId: taskId,
      startedAt: startedAt,
      endedAt: endedAt,
      durationMinutes: durationMinutes,
      completed: completed,
    );
    await remoteDataSource.saveSession(model);
  }
}
