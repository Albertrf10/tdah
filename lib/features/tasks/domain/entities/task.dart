class Task {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String status;
  final String type;
  final String? parentTaskId;
  final int estimatedMinutes;
  final int position;
  final DateTime? createdAt;
  final DateTime? scheduledAt;

  const Task({
    required this.id,
    required this.userId,
    required this.title,
    this.description = '',
    required this.status,
    required this.type,
    this.parentTaskId,
    required this.estimatedMinutes,
    required this.position,
    this.createdAt,
    this.scheduledAt,
  });

  Task copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? status,
    String? type,
    String? parentTaskId,
    int? estimatedMinutes,
    int? position,
    DateTime? createdAt,
    DateTime? scheduledAt,
  }) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      type: type ?? this.type,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      scheduledAt: scheduledAt ?? this.scheduledAt,
    );
  }
}
