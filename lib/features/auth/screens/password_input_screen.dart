import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/network/api_exception.dart';
import 'package:hui_application/core/utils/snackbar_util.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';
import 'package:hui_application/widgets/animated_loading_button.dart';
import 'package:hui_application/widgets/app_text_field.dart';
import 'package:hui_application/widgets/phone_input_field.dart';

class PasswordInputScreen extends ConsumerStatefulWidget {
  final String emailOrPhone;
  const PasswordInputScreen({super.key, required this.emailOrPhone});

  @override
  ConsumerState<PasswordInputScreen> createState() =>
      _PasswordInputScreenState();
}

class _PasswordInputScreenState extends ConsumerState<PasswordInputScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.emailOrPhone;
    _initPhone();
  }

  _initPhone() async {
    final phoneParsed = await emailOrPhone;
    _phoneController.text = phoneParsed['national_number'] ?? '';
  }

  get emailOrPhone async => await parse(widget.emailOrPhone);

  Future<void> _login() async {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final phone = await emailOrPhone;
    try {
      final response = await authNotifier.login(
        phone['e164'],
        _passwordController.text,
      );
      if (response is String) {
        context.go('/home');
        showGlobalSuccessSnackBar(message: response);
      }
    } on ApiException catch (e) {
      if (context.mounted) {
        showGlobalErrorSnackBar(message: e.message.toString());
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
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
        title: Text(S.of(context)!.enter_password),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 48),
            PhoneInputField(controller: _phoneController, enabled: false),
            const SizedBox(height: 24),
            AppTextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              label: S.of(context)!.password,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 32),
            AnimatedCircleButton(
              isLoading: authState.type == AuthStateType.loading,
              onPressed: _passwordController.text.isEmpty ? null : _login,
              title: S.of(context)!.login,
            ),
          ],
        ),
      ),
    );
  }
}
