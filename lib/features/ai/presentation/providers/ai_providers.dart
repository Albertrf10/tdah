import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/ai_repository_impl.dart';
import '../../domain/repositories/ai_repository.dart';

final aiRepositoryProvider = Provider<AiRepository>((ref) {
  return AiRepositoryImpl();
});

final aiBreakdownProvider = FutureProvider.family<List<String>, String>((ref, title) {
  return ref.watch(aiRepositoryProvider).breakdownTask(title);
});
