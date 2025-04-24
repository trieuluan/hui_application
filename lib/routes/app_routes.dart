import 'package:go_router/go_router.dart';
import 'package:hui_application/screens/auth/login_screen.dart';
import 'package:hui_application/screens/auth/register_screen.dart';
import 'package:hui_application/screens/home/home_screen.dart';
import 'package:hui_application/screens/intro_screen.dart';
// import 'package:hui_application/services/auth_manager.dart';
import 'package:hui_application/screens/splash_screen.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  // redirect: (context, state) async {
  //   final loggedIn = await AuthManager.isLoggedIn();
  //   final loggingIn = state.fullPath == '/login';
  //   if (loggedIn && loggingIn) return '/home';
  //   return null;
  // },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/intro', builder: (context, state) => const IntroScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        final emailOrPhone = state.extra as String?;
        return RegisterScreen(emailOrPhone: emailOrPhone);
      },
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
  ],
);
