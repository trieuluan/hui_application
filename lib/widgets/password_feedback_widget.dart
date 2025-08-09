import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:hui_application/core/models/password_strength_response.dart';

class PasswordFeedbackWidget extends StatelessWidget {
  final FormControl<String> passwordControl;
  final PasswordStrengthResponse? strengthResponse;
  final bool showSuggestions;
  final bool isLoading;

  const PasswordFeedbackWidget({
    super.key,
    required this.passwordControl,
    this.strengthResponse,
    this.showSuggestions = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReactiveValueListenableBuilder<String>(
      formControl: passwordControl,
      builder: (context, control, child) {
        final password = control.value ?? '';

        // Don't show feedback if password is empty
        if (password.isEmpty) {
          return const SizedBox.shrink();
        }

        // Show loading state
        if (isLoading) {
          return Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.3,
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
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
        }

        // Show error state if there's an error
        if (strengthResponse == null && !isLoading) {
          return const SizedBox.shrink();
        }

        // Don't show feedback if password is strong
        if (strengthResponse?.isStrong == true) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _getFeedbackColor(theme).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _getFeedbackColor(theme).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Warning section
              if (_hasWarning()) ...[
                Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 16,
                      color: _getFeedbackColor(theme),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _getWarningText(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _getFeedbackColor(theme),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (_hasSuggestions()) const SizedBox(height: 8),
              ],

              // Suggestions section
              if (_hasSuggestions() && showSuggestions) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            _getSuggestions().map((suggestion) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  '• $suggestion',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                ),
              ],

              // Score indicator (optional)
              if (strengthResponse?.score != null) ...[
                const SizedBox(height: 8),
                _buildScoreIndicator(theme),
              ],
            ],
          ),
        );
      },
    );
  }

  Color _getFeedbackColor(ThemeData theme) {
    if (strengthResponse == null) {
      return theme.colorScheme.error;
    }

    final score = strengthResponse!.score;
    if (score <= 1) return theme.colorScheme.error;
    if (score <= 2) return Colors.orange;
    if (score <= 3) return Colors.yellow.shade700;
    return theme.colorScheme.primary;
  }

  bool _hasWarning() {
    if (strengthResponse == null) return false;
    final warning = strengthResponse!.feedback['warning'] as String?;
    return warning != null && warning.isNotEmpty;
  }

  String _getWarningText() {
    if (strengthResponse == null) return '';
    return strengthResponse!.feedback['warning'] as String? ?? '';
  }

  bool _hasSuggestions() {
    if (strengthResponse == null) return false;
    final suggestions =
        strengthResponse!.feedback['suggestions'] as List<dynamic>?;
    return suggestions != null && suggestions.isNotEmpty;
  }

  List<String> _getSuggestions() {
    if (strengthResponse == null) return [];
    final suggestions =
        strengthResponse!.feedback['suggestions'] as List<dynamic>?;
    return suggestions?.cast<String>() ?? [];
  }

  Widget _buildScoreIndicator(ThemeData theme) {
    final score = strengthResponse?.score ?? 0;
    final maxScore = 4;
    final progress = score / maxScore;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Độ mạnh mật khẩu',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              _getScoreText(score),
              style: theme.textTheme.bodySmall?.copyWith(
                color: _getFeedbackColor(theme),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: theme.colorScheme.surfaceContainerLow,
          valueColor: AlwaysStoppedAnimation<Color>(_getFeedbackColor(theme)),
          minHeight: 4,
        ),
      ],
    );
  }

  String _getScoreText(int score) {
    switch (score) {
      case 0:
      case 1:
        return 'Rất yếu';
      case 2:
        return 'Yếu';
      case 3:
        return 'Trung bình';
      case 4:
        return 'Mạnh';
      default:
        return 'Không xác định';
    }
  }
}
