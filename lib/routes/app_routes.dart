import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/features/auth/screens/login_screen.dart';
import 'package:hui_application/features/auth/screens/otp_code_screen.dart';
import 'package:hui_application/features/auth/screens/register_screen.dart';
import 'package:hui_application/screens/home/home_screen.dart';
import 'package:hui_application/screens/intro_screen.dart';
import 'package:hui_application/screens/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final container = ProviderScope.containerOf(context);
    await container.read(authLoadProvider.future);
    final authState = container.read(authProvider);
    // Kiểm tra trạng thái đăng nhập
    if (!authState.isLoggedIn &&
        !['/', '/intro', '/login'].contains(state.uri.toString())) {
      return '/login'; // Redirect to login if not logged in
    }

    // Kiểm tra trạng thái người dùng
    if (authState.isLoggedIn && authState.user['status'] != 'active') {
      return '/verify'; // Điều hướng đến trang xác minh nếu chưa kích hoạt
    }
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/intro', builder: (context, state) => const IntroScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        var emailOrPhone = state.uri.queryParameters['emailOrPhone'];
        if (emailOrPhone == null || emailOrPhone.isEmpty) {
          Future.microtask(() => context.go('/login'));
        }
        emailOrPhone = '+${emailOrPhone!.trim()}';
        return RegisterScreen(emailOrPhone: emailOrPhone);
      },
    ),
    GoRoute(
      path: '/verify',
      builder: (context, state) => const OtpCodeScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
  ],
);
