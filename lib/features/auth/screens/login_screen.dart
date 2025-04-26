import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/widgets/app_text_field.dart';
import 'package:hui_application/core/utils/snackbar_util.dart';
import 'package:hui_application/core/validators/validators.dart';
import 'package:hui_application/services/auth_manager.dart';
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

  @override
  void dispose() {
    _inputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset('assets/logo_hui.png', width: 80),
                const SizedBox(height: 24),
                const Text(
                  'Get started with\nHui Fund',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _formKey.currentState?.validate() == true
                              ? const Color(0xFF2B46F9)
                              : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed:
                        _formKey.currentState?.validate() == true
                            ? () async {
                              try {
                                final avaliable =
                                    await AuthManager.checkAvailability(
                                      _emailOrPhone.trim(),
                                    );
                                if (avaliable) {
                                  context.push(
                                    '/register?emailOrPhone=$_emailOrPhone',
                                  );
                                }
                              } catch (e) {
                                showGlobalErrorSnackBar(message: e.toString());
                              }
                            }
                            : null,
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
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
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(
                      FontAwesomeIcons.squareFacebook,
                      color: Colors.blue,
                      size: 24,
                    ),
                    onPressed: () {},
                    label: const Text('Continue with Facebook'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                      size: 24,
                    ),
                    onPressed: () {},
                    label: const Text('Continue with Google'),
                  ),
                ),
                const Spacer(),
                const Text(
                  'By continuing, you agree to receive calls or messages (including automated) from Hui App and its partners. Reply “STOP” at any time to unsubscribe.',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text.rich(
                  TextSpan(
                    text: 'Protected by reCAPTCHA: Google ',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                    children: [
                      TextSpan(
                        text: 'Policy',
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Terms.',
                        style: TextStyle(color: Colors.blue),
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
