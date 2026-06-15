import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../tasks/presentation/providers/task_providers.dart';
import '../../data/datasources/focus_remote_datasource.dart';
import '../../data/repositories/focus_repository_impl.dart';
import '../../domain/repositories/focus_repository.dart';

final focusRemoteDataSourceProvider = Provider<FocusRemoteDataSource>((ref) {
  return FocusRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final focusRepositoryProvider = Provider<FocusRepository>((ref) {
  return FocusRepositoryImpl(ref.watch(focusRemoteDataSourceProvider));
});
