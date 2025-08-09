import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/features/auth/models/auth_flow_state.dart';
import 'package:hui_application/features/auth/providers/auth_flow_provider.dart';
import 'package:hui_application/features/auth/screens/steps/login_step.dart';
import 'package:hui_application/features/auth/screens/steps/otp_step.dart';
import 'package:hui_application/features/auth/screens/steps/phone_input_step.dart';
import 'package:hui_application/features/auth/screens/steps/profile_setup_step.dart';
import 'package:hui_application/features/auth/screens/steps/register_step.dart';

class UnifiedAuthScreen extends ConsumerStatefulWidget {
  const UnifiedAuthScreen({super.key});

  @override
  ConsumerState<UnifiedAuthScreen> createState() => _UnifiedAuthScreenState();
}

class _UnifiedAuthScreenState extends ConsumerState<UnifiedAuthScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authFlowState = ref.watch(authFlowNotifierProvider);
    final theme = Theme.of(context);

    // Listen to step changes for animations
    ref.listen<AuthFlowState>(authFlowNotifierProvider, (previous, next) {
      if (previous?.currentStep != next.currentStep) {
        _animationController.reset();
        _animationController.forward();
      }
    });

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            if (authFlowState.currentStep != AuthStep.phoneInput)
              _buildHeader(),

            // Main content
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildCurrentStep(authFlowState),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed:
                () => ref.read(authFlowNotifierProvider.notifier).goBack(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 8),
          Text('Quay lại', style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _buildCurrentStep(AuthFlowState state) {
    switch (state.currentStep) {
      case AuthStep.phoneInput:
        return const PhoneInputStep();
      case AuthStep.login:
        return const LoginStep();
      case AuthStep.register:
        return const RegisterStep();
      case AuthStep.profileSetup:
        return const ProfileSetupStep();
      case AuthStep.otp:
        return const OtpStep();
      default:
        return const PhoneInputStep();
    }
  }
}
