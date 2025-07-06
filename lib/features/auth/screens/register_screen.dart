import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/network/api_exception.dart';
import 'package:hui_application/core/utils/snackbar_util.dart';
import 'package:hui_application/core/validators/validators.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/widgets/animated_loading_button.dart';
import 'package:hui_application/widgets/app_reactive_text_field.dart';
import 'package:hui_application/widgets/reactive_intl_phone_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  final String? emailOrPhone;
  const RegisterScreen({super.key, this.emailOrPhone});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;

  bool _isEmailFieldEnabled = true;

  final GlobalKey<ReactiveIntlPhoneFieldState> _phoneFieldKey =
      GlobalKey<ReactiveIntlPhoneFieldState>();

  final form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'phone': FormControl<String>(disabled: true),
    'name': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
    'passwordConfirm': FormControl<String>(
      validators: [
        Validators.required,
        Validators.delegate(makeConfirmValidator('password')),
      ],
    ),
  });

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (widget.emailOrPhone!.isNotEmpty) {
      // print(widget.emailOrPhone);
      final phoneParse = await parse(widget.emailOrPhone!);
      if (phoneParse['type'] == 'mobile') {
        _phoneController.text = phoneParse['national_number'];
      } else {
        _emailController.text = widget.emailOrPhone!;
        setState(() {
          _isEmailFieldEnabled = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Mobile number (disabled)
              ReactiveIntlPhoneField(
                key: _phoneFieldKey,
                controller: _phoneController,
                formControlName: 'phone',
                labelText: 'Phone Number',
              ),
              const SizedBox(height: 24),
              AppReactiveTextField(
                formControlName: 'email',
                label: 'Email',
                controller: _emailController,
                enabled: _isEmailFieldEnabled,
                keyboardType: TextInputType.emailAddress,
                validationMessages: {
                  'required': (control) => 'Email is required',
                  'email': (control) => 'Invalid email format',
                },
              ),
              const SizedBox(height: 16),
              AppReactiveTextField(
                formControlName: 'name',
                controller: _nameController,
                label: 'Full Name',
                validationMessages: {
                  'required': (control) => 'Full name is required',
                },
              ),
              const SizedBox(height: 16),
              AppReactiveTextField(
                formControlName: 'password',
                controller: _passwordController,
                obscureText: _obscurePassword,
                label: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                validationMessages: {
                  'required': (control) => 'Password is required',
                  'minLength':
                      (control) => 'Password must be at least 6 characters',
                },
              ),
              const SizedBox(height: 16),
              AppReactiveTextField(
                formControlName: 'passwordConfirm',
                obscureText: _obscurePasswordConfirm,
                label: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePasswordConfirm
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePasswordConfirm = !_obscurePasswordConfirm;
                    });
                  },
                ),
                validationMessages: {
                  'required': (control) => 'Confirm password is required',
                  'mismatch': (control) => 'Passwords do not match',
                },
              ),
              const SizedBox(height: 32),
              AnimatedCircleButton(
                isLoading: authState.type == AuthStateType.loading,
                onPressed: () async {
                  if (form.valid) {
                    // Perform registration logic here
                    // For example, call an API to register the user
                    // After successful registration, navigate to the next screen
                    try {
                      final result = await ref
                          .read(authNotifierProvider.notifier)
                          .register(
                            emailOrPhone:
                                _phoneFieldKey
                                    .currentState!
                                    .phoneNumber!
                                    .completeNumber,
                            name: form.value['name'] as String,
                            password: form.value['password'] as String,
                            passwordConfirm:
                                form.value['passwordConfirm'] as String,
                            email: form.value['email'] as String,
                          );
                      if (result) {
                        context.go('/home');
                      }
                    } on ApiException catch (e) {
                      // Show the error and suggestions in the snackbar
                      if (context.mounted) {
                        showGlobalErrorSnackBar(
                          message: e.message.toString(),
                          duration: const Duration(seconds: 5),
                        );
                      }
                    }
                  } else {
                    form.markAllAsTouched();
                  }
                },
                title: 'Continue',
              ),
              const SizedBox(height: 24),
              const Text.rich(
                TextSpan(
                  text:
                      'By continuing, you agree that you have read and understood Bookify\'s ',
                  style: TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Terms of Use.',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
