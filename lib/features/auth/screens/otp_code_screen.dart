import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/providers/app_loading_provider.dart';
import 'package:hui_application/core/utils/snackbar_util.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:hui_application/core/utils/phone_utils_extension.dart';

enum OtpScreenMode { loginOtp, registerOtp }

class OtpCodeScreen extends ConsumerStatefulWidget {
  final String? emailOrPhone;
  final OtpScreenMode mode;
  const OtpCodeScreen({
    super.key,
    this.emailOrPhone,
    this.mode = OtpScreenMode.loginOtp,
  });

  @override
  ConsumerState<OtpCodeScreen> createState() => _OtpCodeScreenState();
}

class _OtpCodeScreenState extends ConsumerState<OtpCodeScreen> {
  Timer? _timer;
  int _countdown = 30;
  bool _isResendEnabled = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    _countdown = 30;
    _isResendEnabled = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 0) {
        timer.cancel();
        setState(() {
          _isResendEnabled = true;
        });
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  Future<void> resendOtp() async {
    // Ví dụ: AuthService.sendOtp(widget.emailOrPhone!)
    await ref
        .read(authNotifierProvider.notifier)
        .resendOtp(widget.emailOrPhone!);
    startCountdown(); // reset countdown sau resend
    showGlobalSuccessSnackBar(
      message: 'OTP code resent',
      duration: Duration(seconds: 5),
    );
  }

  Future<void> _onCompleted(String value) async {
    final loadingProvider = ref.read(appLoadingProvider.notifier);
    try {
      loadingProvider.show();
      final success = await ref
          .read(authNotifierProvider.notifier)
          .verifyOtp(value);
      if (!mounted) return;
      final currentAuthState = ref.read(authNotifierProvider);
      if (success) {
        if (widget.mode == OtpScreenMode.registerOtp) {
          context.go('/register?emailOrPhone=${widget.emailOrPhone}');
        } else {
          context.go('/home');
        }
      } else {
        _focusNode.requestFocus();
        showGlobalErrorSnackBar(
          message: currentAuthState.errorMessage ?? 'Invalid OTP code',
          duration: const Duration(seconds: 5),
        );
      }
      loadingProvider.hide();
    } catch (e) {
      _focusNode.requestFocus();
      final currentAuthState = ref.read(authNotifierProvider);
      showGlobalErrorSnackBar(
        message: currentAuthState.errorMessage ?? 'Invalid OTP code',
        duration: const Duration(seconds: 5),
      );
      loadingProvider.hide();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authNotifierProvider).user;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/login');
            }
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Text(
              S.of(context)!.enter_code_message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user?.phone ??
                  user?.phone.toString().maskMiddleOfPhoneNumber(
                    startVisible: 3,
                    endVisible: 2,
                  ) ??
                  widget.emailOrPhone!.maskMiddleOfPhoneNumber(
                    startVisible: 3,
                    endVisible: 2,
                  ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: Text(S.of(context)!.change_number),
            ),
            const SizedBox(height: 32),
            PinCodeTextField(
              appContext: context,
              focusNode: _focusNode,
              length: 6,
              onCompleted: _onCompleted,
              autoFocus: true,
              mainAxisAlignment: MainAxisAlignment.center,
              textStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              showCursor: false,
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
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.circleCheck,
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                      SizedBox(width: 8),
                      Text(
                        S.of(context)!.verification_code_sent,
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    S.of(context)!.text_message_info,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isResendEnabled ? resendOtp : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 12,
                ),
              ),
              child: Text(
                _isResendEnabled
                    ? S.of(context)!.resend_code
                    : '${S.of(context)!.resend_code} ($_countdown)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
