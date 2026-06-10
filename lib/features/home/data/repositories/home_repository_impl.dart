import 'dart:async';
import '../../domain/entities/home_state.dart';
import '../../domain/entities/home_task.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final _controller = StreamController<HomeStateData>.broadcast();
  final List<HomeTask> _mockTasks = [];

  @override
  Stream<HomeStateData> watchHomeState() {
    _emitMockData();
    return _controller.stream;
  }

  @override
  Future<void> addTask(String title) async {
    final newTask = HomeTask(
      id: DateTime.now().toString(),
      title: title,
      estimatedDuration: "5 min",
    );
    _mockTasks.add(newTask);
    _emitMockData();
  }

  void _emitMockData() {
    final pending = _mockTasks.where((t) => !t.isCompleted).toList();
    final completed = _mockTasks.where((t) => t.isCompleted).toList();
    
    _controller.add(HomeStateData(
      currentTask: pending.isNotEmpty ? pending[0] : null,
      nextTask: pending.length > 1 ? pending[1] : null,
      completedTasks: completed.length,
      totalTasks: _mockTasks.length,
    ));
  }
}
