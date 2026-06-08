import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/auth_datasource.dart';

final authControllerProvider =
StateNotifierProvider<AuthController, AsyncValue<void>>(
      (ref) => AuthController(),
);

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController() : super(const AsyncValue.data(null));

  final AuthDataSource _auth = AuthDataSource();

  Future<void> loginEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _auth.loginWithEmail(email: email, password: password);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loginGoogle() async {
    state = const AsyncValue.loading();
    try {
      await _auth.loginWithGoogle();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> register(String email, String password, String username) async {
    state = const AsyncValue.loading();
    try {
      await _auth.register(
        email: email,
        password: password,
        username: username,
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    await _auth.logout();
  }
}