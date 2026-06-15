import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/task.dart';

class TaskModel {
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

  TaskModel({
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

  /// FIRESTORE → MODEL
  factory TaskModel.fromJson(String id, Map<String, dynamic> json) {
    return TaskModel(
      id: id,
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'pending',
      type: json['type'] ?? 'task',
      parentTaskId: json['parentTaskId'],
      estimatedMinutes: json['estimatedMinutes'] ?? 5,
      position: json['position'] ?? 0,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      scheduledAt: json['scheduledAt'] != null
          ? (json['scheduledAt'] as Timestamp).toDate()
          : null,
    );
  }

  /// MODEL → FIRESTORE
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'status': status,
      'type': type,
      'parentTaskId': parentTaskId,
      'estimatedMinutes': estimatedMinutes,
      'position': position,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'scheduledAt': scheduledAt != null ? Timestamp.fromDate(scheduledAt!) : null,
    };
  }

  /// MODEL → ENTITY
  Task toEntity() {
    return Task(
      id: id,
      userId: userId,
      title: title,
      description: description,
      status: status,
      type: type,
      parentTaskId: parentTaskId,
      estimatedMinutes: estimatedMinutes,
      position: position,
      createdAt: createdAt,
      scheduledAt: scheduledAt,
    );
  }

  /// ENTITY → MODEL
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      userId: task.userId,
      title: task.title,
      description: task.description,
      status: task.status,
      type: task.type,
      parentTaskId: task.parentTaskId,
      estimatedMinutes: task.estimatedMinutes,
      position: task.position,
      createdAt: task.createdAt,
      scheduledAt: task.scheduledAt,
    );
  }
}
