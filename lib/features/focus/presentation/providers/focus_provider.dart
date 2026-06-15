import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/controllers/auth_state_provider.dart';
import '../../domain/entities/focus_session.dart';
import '../../domain/repositories/focus_repository.dart';
import 'focus_data_providers.dart';

final focusProvider = StateNotifierProvider.family<FocusNotifier, FocusSession, String>((ref, taskId) {
  final repository = ref.watch(focusRepositoryProvider);
  final userId = ref.watch(authStateProvider).value?.uid ?? '';
  return FocusNotifier(
    taskId: taskId, 
    repository: repository,
    userId: userId,
  );
});

class FocusNotifier extends StateNotifier<FocusSession> {
  final FocusRepository repository;
  final String userId;
  Timer? _timer;
  DateTime? _startedAt;

  FocusNotifier({
    required String taskId, 
    required this.repository,
    required this.userId,
  }) 
    : super(FocusSession(
        taskId: taskId,
        taskTitle: "Cargando tarea...",
        duration: const Duration(minutes: 25),
        remainingTime: const Duration(minutes: 25),
      ));

  void setTaskTitle(String title) {
    state = FocusSession(
      taskId: state.taskId,
      taskTitle: title,
      duration: state.duration,
      remainingTime: state.remainingTime,
      isRunning: state.isRunning,
    );
  }

  void startTimer() {
    if (_timer != null) return;
    _startedAt ??= DateTime.now();
    state = _updateRunning(true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTime.inSeconds > 0) {
        state = FocusSession(
          taskId: state.taskId,
          taskTitle: state.taskTitle,
          duration: state.duration,
          remainingTime: state.remainingTime - const Duration(seconds: 1),
          isRunning: true,
        );
      } else {
        completeSession();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    state = _updateRunning(false);
  }

  Future<void> completeSession({bool manually = false}) async {
    _timer?.cancel();
    _timer = null;
    
    final endedAt = DateTime.now();
    final duration = state.duration.inMinutes;

    final start = _startedAt;
    if (start != null && userId.isNotEmpty) {
      await repository.saveFocusSession(
        taskId: state.taskId,
        userId: userId,
        startedAt: start,
        endedAt: endedAt,
        durationMinutes: duration,
        completed: !manually || state.remainingTime.inSeconds == 0,
      );
    }

    state = _updateRunning(false);
  }

  FocusSession _updateRunning(bool running) {
    return FocusSession(
      taskId: state.taskId,
      taskTitle: state.taskTitle,
      duration: state.duration,
      remainingTime: state.remainingTime,
      isRunning: running,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
