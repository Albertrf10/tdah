class HomeTask {
  final String id;
  final String title;
  final String? estimatedDuration;
  final bool isCompleted;

  HomeTask({
    required this.id,
    required this.title,
    this.estimatedDuration,
    this.isCompleted = false,
  });
}
