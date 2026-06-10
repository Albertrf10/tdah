import 'home_task.dart';

class HomeStateData {
  final HomeTask? currentTask;
  final HomeTask? nextTask;
  final int completedTasks;
  final int totalTasks;

  HomeStateData({
    this.currentTask,
    this.nextTask,
    required this.completedTasks,
    required this.totalTasks,
  });

  bool get isEmpty => currentTask == null;
  double get progress => totalTasks == 0 ? 0 : completedTasks / totalTasks;
}
