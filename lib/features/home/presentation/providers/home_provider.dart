import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/home_state.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_home_state.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl();
});

final homeStateProvider = StreamProvider<HomeStateData>((ref) {
  final useCase = GetHomeState(ref.watch(homeRepositoryProvider));
  return useCase.execute();
});
