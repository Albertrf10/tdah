import '../../data/models/focus_session_model.dart';

abstract class FocusRepository {
  Future<void> saveFocusSession({
    required String taskId,
    required String userId,
    required DateTime startedAt,
    required DateTime endedAt,
    required int durationMinutes,
    required bool completed,
  });
}
