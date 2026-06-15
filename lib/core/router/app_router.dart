import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/controllers/auth_state_provider.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/focus/presentation/screens/focus_screen.dart';
import '../../features/tasks/presentation/screens/achievements_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',

    redirect: (context, state) {
      final user = authState.valueOrNull;

      final isLogin = state.matchedLocation == '/login';
      final isRegister = state.matchedLocation == '/register';

      if (authState.isLoading) return null;

      // ❌ no user → login
      if (user == null) {
        return (isLogin || isRegister) ? null : '/login';
      }

      // ✅ user logged → home
      if (isLogin || isRegister) {
        return '/home';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: '/focus/:taskId',
        builder: (_, state) {
          final taskId = state.pathParameters['taskId']!;
          return FocusScreen(taskId: taskId);
        },
      ),
      GoRoute(
        path: '/achievements',
        builder: (_, __) => const AchievementsScreen(),
      ),
    ],
  );
});