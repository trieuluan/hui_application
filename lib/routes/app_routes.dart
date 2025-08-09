import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/guards/auth_guard.dart';
import 'package:hui_application/core/navigator_keys.dart';
import 'package:hui_application/features/account/screens/account_screen.dart';
import 'package:hui_application/features/account/screens/settings_screen.dart';
import 'package:hui_application/features/auth/screens/unified_auth_screen.dart';
import 'package:hui_application/features/groups/screens/group_create_update_screen.dart';
import 'package:hui_application/features/discovery/screens/discovery_screen.dart';
import 'package:hui_application/features/groups/screens/group_list_screen.dart';
import 'package:hui_application/features/groups/screens/group_screen.dart';
import 'package:hui_application/features/home/home_screen.dart';
import 'package:hui_application/routes/tab_scaffold_shell.dart';
import 'package:hui_application/screens/intro_screen.dart';
import 'package:hui_application/screens/splash_screen.dart';
import 'package:animations/animations.dart';

final allowedUnauthenticatedRoutes = {
  '/',
  '/intro',
  '/auth',
  '/register',
  '/otp-register',
  '/otp-login',
  RegExp(r'^/password/[^/]+$'),
};

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    // initialLocation: '/',
    redirect: (context, state) {
      final location = state.matchedLocation;
      if (location == '/') return null;
      bool isAllowed = allowedUnauthenticatedRoutes.any((allowed) {
        if (allowed is String) {
          return location == allowed;
        } else if (allowed is RegExp) {
          return allowed.hasMatch(location);
        }
        return false;
      });
      if (requireAuth(ref) && isAllowed) {
        return '/discovery';
      }
      if (guestOnly(ref) && !isAllowed) {
        if (state.matchedLocation != '/auth') {
          return '/auth'; // Chỉ redirect nếu không phải đang ở /auth
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/intro', builder: (context, state) => const IntroScreen()),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const UnifiedAuthScreen(),
      ),
      StatefulShellRoute(
        builder: (context, state, navigationShell) {
          return TabScaffoldShell(navigationShell: navigationShell);
        },
        navigatorContainerBuilder:
            (context, navigationShell, children) => PageTransitionSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                return FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
              child: children[navigationShell.currentIndex],
            ),
        parentNavigatorKey: rootNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: DiscoveryScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: groupsNavigatorKey,
            routes: [
              GoRoute(
                path: '/groups',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: GroupListScreen()),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder:
                        (context, state) => const GroupCreateUpdateScreen(),
                  ),
                  GoRoute(
                    path: ':id',
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id'] ?? '';
                      return NoTransitionPage(child: GroupScreen(id: id));
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: discoveryNavigatorKey,
            routes: [
              GoRoute(
                path: '/discovery',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: accountNavigatorKey,
            routes: [
              GoRoute(
                path: '/account',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: AccountScreen()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );

  return router;
});
