import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';
import 'task_remote_datasource.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore firestore;

  TaskRemoteDataSourceImpl(this.firestore);

  final String collection = 'tasks';

  @override
  Stream<List<TaskModel>> watchPending(String userId) {
    return firestore
        .collection(collection)
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TaskModel.fromJson(doc.id, doc.data()))
          .toList();
    });
  }

  @override
  Stream<List<TaskModel>> watchCompleted(String userId) {
    return firestore
        .collection(collection)
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'completed')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TaskModel.fromJson(doc.id, doc.data()))
          .toList();
    });
  }

  @override
  Future<void> create(TaskModel task) async {
    await firestore.collection(collection).add(task.toJson());
  }

  @override
  Future<void> complete(String taskId) async {
    await firestore.collection(collection).doc(taskId).update({
      'status': 'completed',
    });
  }
}
