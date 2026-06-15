import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdah_app/features/auth/presentation/controllers/auth_state_provider.dart';
import 'package:tdah_app/features/tasks/data/datasources/task_remote_datasource_impl.dart';
import 'package:tdah_app/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:tdah_app/features/tasks/domain/entities/task.dart';
import 'package:tdah_app/features/tasks/domain/repositories/task_repository.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final taskRemoteDataSourceProvider = Provider((ref) {
  return TaskRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final tasksRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(ref.watch(taskRemoteDataSourceProvider));
});

final pendingTasksProvider = StreamProvider<List<Task>>((ref) {
  final user = ref.watch(authStateProvider).valueOrNull;
  if (user == null) return Stream.value([]);
  
  return ref.watch(tasksRepositoryProvider).watchPending(user.uid);
});

final completedTasksProvider = StreamProvider<List<Task>>((ref) {
  final user = ref.watch(authStateProvider).valueOrNull;
  if (user == null) return Stream.value([]);
  
  return ref.watch(tasksRepositoryProvider).watchCompleted(user.uid);
});
