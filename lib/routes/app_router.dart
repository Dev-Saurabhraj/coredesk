import 'package:go_router/go_router.dart';
import 'package:coredesk/features/authentication/presentation/pages/login_page.dart';
import 'package:coredesk/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:coredesk/shared/services/index.dart';

GoRouter createRouter(AuthService authService) {
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: false,
    redirect: (context, state) async {
      final isLoggedIn = await authService.isLoggedIn();
      final isLoginPage = state.matchedLocation == '/login';

      if (isLoggedIn) {
        if (isLoginPage) {
          return '/dashboard';
        }
      } else {
        if (!isLoginPage) {
          return '/login';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginPage()),
      ),
      GoRoute(
        path: '/dashboard',
        pageBuilder: (context, state) {
          final token = authService.getToken() ?? '';
          return NoTransitionPage(child: DashboardPage(token: token));
        },
      ),
    ],
  );
}
