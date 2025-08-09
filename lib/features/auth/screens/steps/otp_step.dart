import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/utils/snackbar_util.dart';
import 'package:hui_application/features/auth/providers/auth_flow_provider.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/widgets/animated_loading_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpStep extends ConsumerStatefulWidget {
  const OtpStep({super.key});

  @override
  ConsumerState<OtpStep> createState() => _OtpStepState();
}

class _OtpStepState extends ConsumerState<OtpStep> {
  final FocusNode _focusNode = FocusNode();
  bool _isLoading = false;
  String _otp = '';

  @override
  void dispose() {
    // Let Flutter handle focus node disposal automatically
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    if (_otp.length != 6) {
      showGlobalErrorSnackBar(message: 'Vui lòng nhập đủ 6 số OTP');
      return;
    }

    setState(() {
      _isLoading = true;
    });
    try {
      final result = await ref
          .read(authNotifierProvider.notifier)
          .verifyOtp(_otp);

      if (result) {
        // OTP verified successfully, now login with password
        final authFlowState = ref.read(authFlowNotifierProvider);
        final loginResult = await ref
            .read(authNotifierProvider.notifier)
            .login(
              authFlowState.phoneNumber?.e164 ?? '',
              authFlowState.password ?? '',
            );

        if (loginResult.runtimeType == bool && !loginResult) {
          showGlobalErrorSnackBar(message: 'Đăng nhập thất bại');
        } else {
          showGlobalSuccessSnackBar(
            message: loginResult['message'] ?? 'Đăng nhập thành công',
          );
          context.go('/home');
        }
      } else {
        showGlobalErrorSnackBar(message: 'Mã OTP không đúng');
      }
    } catch (e) {
      showGlobalErrorSnackBar(
        message: 'Xác thực OTP thất bại: ${e.toString()}',
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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

          // OTP icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: theme.colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.security,
              size: 40,
              color: theme.colorScheme.tertiary,
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Xác thực tài khoản',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          Text(
            'Nhập mã OTP đã được gửi đến',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          Text(
            authFlowState.phoneNumber?.e164 ?? '',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),

          PinCodeTextField(
            appContext: context,
            focusNode: _focusNode,
            length: 6,
            onChanged: (value) {
              setState(() {
                _otp = value;
              });
            },
            onCompleted: (value) {
              _verifyOtp();
            },
            autoFocus: true,
            mainAxisAlignment: MainAxisAlignment.center,
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            showCursor: false,
            backgroundColor: Colors.transparent,
            pinTheme: PinTheme(
              selectedColor: Theme.of(context).colorScheme.onSurface,
              selectedFillColor: Theme.of(context).colorScheme.surface,
              inactiveColor: Theme.of(context).colorScheme.outline,
              inactiveFillColor: Theme.of(context).colorScheme.surface,
              activeFillColor: Theme.of(context).colorScheme.surface,
              activeColor: Theme.of(context).colorScheme.primary,
              fieldOuterPadding: const EdgeInsets.all(4),
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8),
              fieldHeight: 48,
              fieldWidth: 48,
            ),
            enableActiveFill: true,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 32),

          // Verify button
          AnimatedCircleButton(
            onPressed: () => _verifyOtp(),
            title: 'Xác thực',
            isLoading: _isLoading,
          ),
          const SizedBox(height: 16),

          // Resend OTP
          TextButton(
            onPressed:
                _isLoading
                    ? null
                    : () async {
                      try {
                        final authFlowState = ref.read(
                          authFlowNotifierProvider,
                        );
                        await ref
                            .read(authNotifierProvider.notifier)
                            .sendOtp(authFlowState.phoneNumber?.e164 ?? '');

                        showGlobalSuccessSnackBar(message: 'Đã gửi lại mã OTP');
                      } catch (e) {
                        showGlobalErrorSnackBar(
                          message: 'Không thể gửi lại OTP: ${e.toString()}',
                        );
                      }
                    },
            child: Text(
              'Gửi lại mã OTP',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
