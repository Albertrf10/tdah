import '../entities/home_state.dart';

abstract class HomeRepository {
  Stream<HomeStateData> watchHomeState();
  Future<void> addTask(String title);
}
