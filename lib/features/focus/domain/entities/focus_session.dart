class FocusSession {
  final String taskId;
  final String taskTitle;
  final Duration duration;
  final Duration remainingTime;
  final bool isRunning;

  FocusSession({
    required this.taskId,
    required this.taskTitle,
    required this.duration,
    required this.remainingTime,
    this.isRunning = false,
  });

  double get progress => 1 - (remainingTime.inSeconds / duration.inSeconds);
  
  String get remainingFormatted {
    final minutes = remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
