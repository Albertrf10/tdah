import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasource/auth_datasource.dart';

final authControllerProvider =
StateNotifierProvider<AuthController, AsyncValue<void>>(
      (ref) => AuthController(),
);

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController() : super(const AsyncValue.data(null));

  final AuthDataSource _auth = AuthDataSource();

  Future<void> loginEmail(String email, String password, {bool rememberMe = false}) async {
    state = const AsyncValue.loading();
    try {
      await _auth.loginWithEmail(email: email, password: password);
      await _saveRememberMe(rememberMe);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loginGoogle({bool rememberMe = false}) async {
    state = const AsyncValue.loading();
    try {
      await _auth.loginWithGoogle();
      await _saveRememberMe(rememberMe);
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
      // Por defecto no guardamos persistencia en registro a menos que se quiera
      await _saveRememberMe(false); 
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> _saveRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', value);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', false);
    await _auth.logout();
  }
}