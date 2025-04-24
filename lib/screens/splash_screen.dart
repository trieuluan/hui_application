import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/services/auth_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      // Navigate to the intro screen
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        context.go('/intro');
      });
      // Set the flag to false
      await prefs.setBool('isFirstTime', false);
    } else {
      final isLoggedIn = await AuthManager.isLoggedIn();
      if (!mounted) return;
      // Navigate to the main screen
      context.go(isLoggedIn ? '/home' : '/intro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0051CC), // nền xanh đồng bộ với logo
      body: Center(
        child: Lottie.asset(
          'assets/animations/splash_animation.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          },
          fit: BoxFit.contain,
          frameRate: FrameRate.max,
        ),
      ),
    );
  }
}
