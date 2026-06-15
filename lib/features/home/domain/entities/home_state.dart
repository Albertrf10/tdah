import '../../../tasks/domain/entities/task.dart';

class HomeStateData {
  final Task? currentTask;
  final Task? nextTask;
  final int completedTasks;
  final int totalTasks;
  final int activeTasksCount;
  final int inactiveTasksCount;

  HomeStateData({
    this.currentTask,
    this.nextTask,
    required this.completedTasks,
    required this.totalTasks,
    required this.activeTasksCount,
    required this.inactiveTasksCount,
  });

  bool get isEmpty => currentTask == null;
  double get progress => totalTasks == 0 ? 0 : completedTasks / totalTasks;
}
