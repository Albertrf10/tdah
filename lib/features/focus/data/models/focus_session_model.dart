import 'package:cloud_firestore/cloud_firestore.dart';

class FocusSessionModel {
  final String? id;
  final String userId;
  final String taskId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int durationMinutes;
  final bool completed;

  FocusSessionModel({
    this.id,
    required this.userId,
    required this.taskId,
    required this.startedAt,
    this.endedAt,
    required this.durationMinutes,
    required this.completed,
  });

  factory FocusSessionModel.fromJson(String id, Map<String, dynamic> json) {
    return FocusSessionModel(
      id: id,
      userId: json['userId'] ?? '',
      taskId: json['taskId'] ?? '',
      startedAt: (json['startedAt'] as Timestamp).toDate(),
      endedAt: json['endedAt'] != null ? (json['endedAt'] as Timestamp).toDate() : null,
      durationMinutes: json['durationMinutes'] ?? 0,
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'taskId': taskId,
      'startedAt': Timestamp.fromDate(startedAt),
      'endedAt': endedAt != null ? Timestamp.fromDate(endedAt!) : null,
      'durationMinutes': durationMinutes,
      'completed': completed,
    };
  }
}
