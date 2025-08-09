import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/features/auth/providers/auth_flow_provider.dart';
import 'package:hui_application/widgets/animated_loading_button.dart';
import 'package:hui_application/widgets/app_logo.dart';
import 'package:hui_application/widgets/app_text_field.dart';

class LoginStep extends ConsumerStatefulWidget {
  const LoginStep({super.key});

  @override
  ConsumerState<LoginStep> createState() => _LoginStepState();
}

class _LoginStepState extends ConsumerState<LoginStep> {
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    phoneParsed();
  }

  void phoneParsed() async {
    final phone =
        ref.read(authFlowNotifierProvider).phoneNumber?.completeNumber ?? '';
    final phoneParsed = await parse(phone);
    setState(() {
      phoneNumber = phoneParsed['e164'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final authFlowState = ref.watch(authFlowNotifierProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),

          // Welcome back icon
          AppLogo(),
          const SizedBox(height: 24),

          Text(
            'Chào mừng trở lại!',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          Text(
            'Nhập mật khẩu để đăng nhập',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          Text(
            phoneNumber ?? '',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),

          // Password input
          AppTextField(
            label: 'Mật khẩu',
            onChanged: (value) {
              ref.read(authFlowNotifierProvider.notifier).setPassword(value);
            },
            obscureText: !authFlowState.isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                authFlowState.isPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              onPressed: () {
                ref
                    .read(authFlowNotifierProvider.notifier)
                    .togglePasswordVisibility();
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          // Login button
          SizedBox(
            width: double.infinity,
            child: AnimatedCircleButton(
              isLoading: authFlowState.isLoading,
              onPressed:
                  () =>
                      ref.read(authFlowNotifierProvider.notifier).handleLogin(),
              title: 'Đăng nhập',
            ),
          ),
          const SizedBox(height: 16),

          // Forgot password
          TextButton(
            onPressed: () {},
            child: Text(
              'Quên mật khẩu?',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
