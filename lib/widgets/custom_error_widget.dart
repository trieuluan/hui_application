import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  final VoidCallback? onRetry;
  final bool showDetails;

  const CustomErrorWidget({
    super.key,
    required this.errorDetails,
    this.onRetry,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Error Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(
                  Icons.error_outline,
                  size: 60,
                  color: theme.colorScheme.error,
                ),
              ),
              const SizedBox(height: 32),

              // Error Title
              Text(
                'Đã xảy ra lỗi',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Error Message
              Text(
                'Ứng dụng gặp sự cố không mong muốn. Vui lòng thử lại hoặc liên hệ hỗ trợ nếu vấn đề vẫn tiếp tục.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Retry Button
                  if (onRetry != null)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onRetry,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Thử lại'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),

                  if (onRetry != null) const SizedBox(width: 16),

                  // Restart App Button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _restartApp(),
                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Khởi động lại'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Show Details Toggle
              if (showDetails)
                _buildErrorDetails(theme)
              else
                TextButton(
                  onPressed: () => _showErrorDetails(context),
                  child: const Text('Xem chi tiết lỗi'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorDetails(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bug_report, size: 20, color: theme.colorScheme.error),
              const SizedBox(width: 8),
              Text(
                'Chi tiết lỗi',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Exception: ${errorDetails.exception}',
            style: theme.textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (errorDetails.stack != null) ...[
            const SizedBox(height: 8),
            Text(
              'Stack Trace:',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: theme.colorScheme.outline),
              ),
              child: SingleChildScrollView(
                child: Text(
                  errorDetails.stack.toString(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.copy, size: 16, color: theme.colorScheme.primary),
              const SizedBox(width: 4),
              TextButton(
                onPressed: () => _copyErrorDetails(),
                child: const Text('Sao chép'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showErrorDetails(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Chi tiết lỗi',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: _buildErrorDetails(Theme.of(context)),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Đóng'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _copyErrorDetails() {
    final errorText = '''
Exception: ${errorDetails.exception}
Stack Trace: ${errorDetails.stack}
''';

    Clipboard.setData(ClipboardData(text: errorText));

    // Show snackbar (if we have a context)
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Đã sao chép chi tiết lỗi')),
    // );
  }

  void _restartApp() {
    // This is a simplified restart - in a real app you might want to use
    // a package like restart_app or implement a more sophisticated restart
    SystemNavigator.pop();
  }
}

// Custom Error Widget Builder
class CustomErrorWidgetBuilder {
  static Widget buildErrorWidget(
    FlutterErrorDetails errorDetails, {
    VoidCallback? onRetry,
    bool showDetails = false,
  }) {
    return CustomErrorWidget(
      errorDetails: errorDetails,
      onRetry: onRetry,
      showDetails: showDetails,
    );
  }
}
