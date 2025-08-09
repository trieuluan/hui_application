import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hui_application/core/validators/validators.dart';
import 'package:hui_application/features/auth/providers/auth_flow_provider.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';
import 'package:hui_application/widgets/animated_loading_button.dart';
import 'package:hui_application/widgets/app_logo.dart';
import 'package:hui_application/widgets/reactive_intl_phone_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PhoneInputStep extends ConsumerStatefulWidget {
  const PhoneInputStep({super.key});

  @override
  ConsumerState<PhoneInputStep> createState() => _PhoneInputStepState();
}

class _PhoneInputStepState extends ConsumerState<PhoneInputStep> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();

    // Initialize form with proper initial value
    final initialPhoneNumber = ref.read(authFlowNotifierProvider).phoneNumber;

    form = FormGroup({
      'phone': FormControl<ParsedPhoneData>(
        validators: [Validators.required],
        asyncValidators: [DelegateAsyncValidator(makePhoneValidator())],
        value: initialPhoneNumber, // Explicitly set nullable value
      ),
    });

    // Listen to phone number changes
    form.control('phone').valueChanges.listen((value) async {
      try {
        final phoneParsed = await parse(value.completeNumber);
        ref
            .read(authFlowNotifierProvider.notifier)
            .setPhoneNumber(
              ParsedPhoneData(
                e164: phoneParsed['e164'],
                nationalNumber: phoneParsed['national_number'],
                countryCode: phoneParsed['country_code'],
                regionCode: phoneParsed['region_code'],
                completeNumber: value.completeNumber,
                number: value.number,
              ),
            );
      } catch (e) {
        // print(e);
        ref.read(authFlowNotifierProvider.notifier).setPhoneNumber(null);
      }
    });
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authFlowState = ref.watch(authFlowNotifierProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Logo
            AppLogo(),
            const SizedBox(height: 32),
            // Welcome text
            Text(
              S.of(context)!.welcome_to_hui_fund,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Text(
              S.of(context)!.enter_phone_number_to_continue,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Phone input
            ReactiveIntlPhoneField(
              formControlName: 'phone',
              labelText: 'Phone Number',
            ),

            const SizedBox(height: 24),

            // Continue button
            ReactiveFormConsumer(
              builder: (context, control, child) {
                return AnimatedCircleButton(
                  isLoading: authFlowState.isLoading,
                  onPressed:
                      form.valid
                          ? () async {
                            ref
                                .read(authFlowNotifierProvider.notifier)
                                .checkAccount();
                          }
                          : null,
                  title: S.of(context)!.continue_,
                );
              },
            ),
            const SizedBox(height: 24),

            // Social login options
            _buildSocialLoginOptions(context, theme),

            const Spacer(),

            // Terms and privacy
            _buildTermsAndPrivacy(context, theme),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLoginOptions(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: theme.colorScheme.outlineVariant)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'hoặc',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Expanded(child: Divider(color: theme.colorScheme.outlineVariant)),
          ],
        ),
        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurfaceVariant,
              backgroundColor: theme.colorScheme.surfaceContainerHigh,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
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
              foregroundColor: theme.colorScheme.onSurfaceVariant,
              backgroundColor: theme.colorScheme.surfaceContainerHigh,
              padding: const EdgeInsets.symmetric(vertical: 16),
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
            label: Text(S.of(context)!.continue_google),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndPrivacy(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        Text(
          S.of(context)!.agreement_message,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),

        Text.rich(
          TextSpan(
            text: S.of(context)!.recaptcha_protected,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            children: [
              TextSpan(
                text: S.of(context)!.google_policy,
                style: TextStyle(color: theme.colorScheme.primary),
              ),
              TextSpan(text: ' ${S.of(context)!.and} '),
              TextSpan(
                text: S.of(context)!.google_terms,
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
