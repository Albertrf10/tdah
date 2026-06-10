import '../entities/home_state.dart';
import '../repositories/home_repository.dart';

class GetHomeState {
  final HomeRepository repository;
  GetHomeState(this.repository);

  Stream<HomeStateData> execute() => repository.watchHomeState();
}
