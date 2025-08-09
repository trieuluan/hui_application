import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PasswordStrengthLoadingWidget extends StatelessWidget {
  final FormControl<String> passwordControl;

  const PasswordStrengthLoadingWidget({
    super.key,
    required this.passwordControl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReactiveValueListenableBuilder<String>(
      formControl: passwordControl,
      builder: (context, control, child) {
        final password = control.value ?? '';

        // Don't show loading if password is empty or too short
        if (password.isEmpty || password.length < 6) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Đang kiểm tra độ mạnh mật khẩu...',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
