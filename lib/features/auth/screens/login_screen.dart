import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/network/api_exception.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';
import 'package:hui_application/widgets/animated_loading_button.dart';
import 'package:hui_application/widgets/app_logo.dart';
import 'package:hui_application/widgets/app_text_field.dart';
import 'package:hui_application/core/utils/snackbar_util.dart';
import 'package:hui_application/core/validators/validators.dart';
import 'package:hui_application/widgets/phone_input_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final GlobalKey<PhoneInputFieldState> _phoneKey =
      GlobalKey<PhoneInputFieldState>();
  final _formKey = GlobalKey<FormState>();
  bool _isPhone = false;
  String _emailOrPhone = '';

  String _previousText = '';

  @override
  void initState() {
    super.initState();
    _isPhone = true;
    // _inputController.addListener(_checkInputType);
  }

  // ignore: unused_element
  void _checkInputType() {
    final text = _inputController.text.trim();
    if (text == _previousText) return;
    _previousText = text;
    final isNumeric = RegExp(r'^\d{4,}$').hasMatch(text);
    setState(() {
      _isPhone = isNumeric;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isPhone) {
        _phoneFocusNode.requestFocus();
        _phoneKey.currentState?.validatePhone(
          PhoneNumber(
            number: text,
            countryCode: _phoneKey.currentState?.countryCode ?? '',
            countryISOCode: _phoneKey.currentState?.countryISOCode ?? '',
          ),
        );
      } else {
        _focusNode.requestFocus();
      }
      Future.delayed(Duration.zero, () {
        _inputController.selection = TextSelection.fromPosition(
          TextPosition(offset: _inputController.text.length),
        );
      });
    });
  }

  get emailOrPhone async => await parse(_emailOrPhone);

  @override
  void dispose() {
    _inputController.dispose();
    _focusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                AppLogo(),
                const SizedBox(height: 24),
                Text(
                  S.of(context)!.get_start,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child:
                          _isPhone
                              ? PhoneInputField(
                                key: _phoneKey,
                                focusNode: _phoneFocusNode,
                                controller: _inputController,
                                onChanged:
                                    (phone) => {
                                      setState(() {
                                        _emailOrPhone = phone.completeNumber;
                                      }),
                                    },
                              )
                              : AppTextField(
                                label: 'Email or Phone',
                                controller: _inputController,
                                focusNode: _focusNode,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => validateEmail(value),
                                onChanged:
                                    (value) => setState(() {
                                      _emailOrPhone = value;
                                    }),
                              ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                AnimatedCircleButton(
                  isLoading: authState.type == AuthStateType.loading,
                  onPressed:
                      _formKey.currentState?.validate() == true
                          ? () async {
                            try {
                              final phoneParse = await emailOrPhone;
                              final authNotifier = ref.read(
                                authNotifierProvider.notifier,
                              );
                              authNotifier.showLoading();
                              final isAvailable = await authNotifier
                                  .checkAvailability(phoneParse['e164']);
                              if (!isAvailable) {
                                await authNotifier.sendOtp(phoneParse['e164']);
                                context.push(
                                  '/otp-register?emailOrPhone=${phoneParse['e164']}',
                                );
                              } else {
                                context.push(
                                  '/password/${Uri.encodeComponent(phoneParse['e164'])}',
                                );
                              }
                              authNotifier.hideLoading();
                            } on ApiException catch (e) {
                              if (context.mounted) {
                                showGlobalErrorSnackBar(
                                  message: e.message.toString(),
                                  duration: const Duration(seconds: 5),
                                );
                              }
                            }
                          }
                          : null,
                  title: S.of(context)!.continue_,
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('or'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).colorScheme.onSurfaceVariant,
                      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
                    ),
                    icon: Icon(
                      FontAwesomeIcons.squareFacebook,
                      color: Colors.blue.shade700,
                      size: 24,
                    ),
                    onPressed: () {},
                    label: Text(S.of(context)!.continue_facebook),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).colorScheme.onSurfaceVariant,
                      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
                    ),
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                      size: 24,
                    ),
                    onPressed: () {},
                    label: Text(S.of(context)!.continue_google),
                  ),
                ),
                const Spacer(),
                Text(
                  S.of(context)!.agreement_message,
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    text:
                        S
                            .of(context)!
                            .recaptcha_protected, // Chuỗi đa ngôn ngữ cho "Protected by reCAPTCHA: Google"
                    style: const TextStyle(fontSize: 12),
                    children: [
                      TextSpan(
                        text:
                            S
                                .of(context)!
                                .google_policy, // Chuỗi đa ngôn ngữ cho "Policy"
                        style: const TextStyle(color: Colors.blue),
                      ),
                      TextSpan(
                        text: ' ${S.of(context)!.and} ',
                      ), // Khoảng trắng hoặc "and" nếu cần dịch
                      TextSpan(
                        text:
                            S
                                .of(context)!
                                .google_terms, // Chuỗi đa ngôn ngữ cho "Terms"
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
