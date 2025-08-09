import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PasswordRequirementsWidget extends StatelessWidget {
  final Map<String, dynamic> passwordConfig;
  final FormControl<String> passwordControl;

  const PasswordRequirementsWidget({
    super.key,
    required this.passwordConfig,
    required this.passwordControl,
  });

  @override
  Widget build(BuildContext context) {
    final requirements =
        passwordConfig['requirements'] as Map<String, dynamic>?;
    if (requirements == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final password = passwordControl.value ?? '';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yêu cầu mật khẩu:',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          _buildRequirementItem(
            'Tối thiểu ${passwordConfig['minLength']} ký tự',
            password.length >= (passwordConfig['minLength'] as int? ?? 6),
          ),
          if (requirements['uppercase'] == true)
            _buildRequirementItem(
              'Có ít nhất 1 chữ hoa',
              RegExp(r'[A-Z]').hasMatch(password),
            ),
          if (requirements['lowercase'] == true)
            _buildRequirementItem(
              'Có ít nhất 1 chữ thường',
              RegExp(r'[a-z]').hasMatch(password),
            ),
          if (requirements['numbers'] == true)
            _buildRequirementItem(
              'Có ít nhất 1 số',
              RegExp(r'[0-9]').hasMatch(password),
            ),
          if (requirements['specialChars'] == true)
            _buildRequirementItem(
              'Có ít nhất 1 ký tự đặc biệt',
              RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password),
            ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool isMet) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Icon(
                isMet ? Icons.check_circle : Icons.circle_outlined,
                size: 16,
                color:
                    isMet
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: theme.textTheme.bodySmall?.copyWith(
                  color:
                      isMet
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
