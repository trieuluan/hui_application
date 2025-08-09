import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/features/auth/providers/auth_flow_provider.dart';
import 'package:hui_application/features/auth/providers/password_strength_provider.dart';
import 'package:hui_application/widgets/animated_loading_button.dart';
import 'package:hui_application/widgets/app_reactive_text_field.dart';
import 'package:hui_application/widgets/password_requirements_widget.dart';
import 'package:hui_application/widgets/password_feedback_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:hui_application/core/services/password_validator_service.dart';

class RegisterStep extends ConsumerStatefulWidget {
  const RegisterStep({super.key});

  @override
  ConsumerState<RegisterStep> createState() => _RegisterStepState();
}

class _RegisterStepState extends ConsumerState<RegisterStep> {
  FormGroup? form;
  Map<String, dynamic>? _passwordConfig;
  late final Future<void> _initializationFuture;

  @override
  void initState() {
    super.initState();
    _initializationFuture = _initializeForm();
  }

  Future<void> _initializeForm() async {
    // Get password config from API first
    await _loadPasswordConfig();
    form = FormGroup({
      'password': FormControl<String>(
        validators: PasswordValidatorService.createPasswordValidators(
          _passwordConfig!,
        ),
        asyncValidators: PasswordValidatorService.createPasswordAsyncValidators(
          ref,
        ),
      ),
      'confirmPassword': FormControl<String>(
        validators: PasswordValidatorService.createConfirmPasswordValidators(
          _passwordConfig!,
        ),
      ),
    });

    // Add cross-field validation for password confirmation
    form!.setValidators([Validators.mustMatch('password', 'confirmPassword')]);
  }

  Future<void> _loadPasswordConfig() async {
    _passwordConfig = await PasswordValidatorService.loadPasswordConfig(ref);
  }

  Widget _buildPasswordRequirements() {
    if (_passwordConfig == null || form == null) return const SizedBox.shrink();

    return PasswordRequirementsWidget(
      passwordConfig: _passwordConfig!,
      passwordControl: form!.control('password') as FormControl<String>,
    );
  }

  Widget _buildPasswordFeedback() {
    if (form == null) return const SizedBox.shrink();

    final strengthState = ref.watch(passwordStrengthNotifierProvider);
    final passwordControl = form!.control('password') as FormControl<String>;

    return PasswordFeedbackWidget(
      passwordControl: passwordControl,
      strengthResponse: strengthState.response,
      showSuggestions: true,
      isLoading: strengthState.isLoading,
    );
  }

  @override
  void dispose() {
    form?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authFlowState = ref.watch(authFlowNotifierProvider);
    final theme = Theme.of(context);

    return FutureBuilder<void>(
      future: _initializationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Lỗi khởi tạo: ${snapshot.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _initializationFuture = _initializeForm();
                    });
                  },
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          );
        }

        if (form == null) {
          return const Center(child: Text('Form chưa sẵn sàng'));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ReactiveForm(
            formGroup: form!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Create account icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(
                    Icons.person_add,
                    size: 40,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'Tạo tài khoản mới',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                Text(
                  'Thiết lập mật khẩu cho tài khoản của bạn',
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

                // Password input
                AppReactiveTextField(
                  label: 'Mật khẩu',
                  formControlName: 'password',
                  onChanged: (control) {
                    final password = control.value as String;
                    ref
                        .read(authFlowNotifierProvider.notifier)
                        .setPassword(password);
                  },
                  obscureText: !authFlowState.isPasswordVisible,
                  validationMessages:
                      PasswordValidatorService.createPasswordValidationMessages(
                        _passwordConfig!,
                      ),
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
                ),
                const SizedBox(height: 6),
                // Password requirements indicator
                if (_passwordConfig != null) _buildPasswordRequirements(),

                // Password feedback from BE
                _buildPasswordFeedback(),

                const SizedBox(height: 16),

                // Confirm password input
                AppReactiveTextField(
                  label: 'Xác nhận mật khẩu',
                  formControlName: 'confirmPassword',
                  onChanged: (control) {
                    ref
                        .read(authFlowNotifierProvider.notifier)
                        .setConfirmPassword(control.value as String);
                  },
                  obscureText: !authFlowState.isConfirmPasswordVisible,
                  validationMessages:
                      PasswordValidatorService.createConfirmPasswordValidationMessages(
                        _passwordConfig!,
                      ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      authFlowState.isConfirmPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    onPressed: () {
                      ref
                          .read(authFlowNotifierProvider.notifier)
                          .toggleConfirmPasswordVisibility();
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // Register button
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return SizedBox(
                      width: double.infinity,
                      child: AnimatedCircleButton(
                        isLoading: authFlowState.isLoading,
                        onPressed:
                            form.valid
                                ? () =>
                                    ref
                                        .read(authFlowNotifierProvider.notifier)
                                        .handleRegister()
                                : null,
                        title: 'Tạo tài khoản',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
