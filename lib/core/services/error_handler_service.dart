import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hui_application/widgets/custom_error_widget.dart';

class ErrorHandlerService {
  static final ErrorHandlerService _instance = ErrorHandlerService._internal();
  factory ErrorHandlerService() => _instance;
  ErrorHandlerService._internal();

  // Global error handler
  static void handleError(FlutterErrorDetails details) {
    // Log error to console
    FlutterError.dumpErrorToConsole(details);

    // You can add more error handling here:
    // - Send to crash reporting service (Firebase Crashlytics, Sentry, etc.)
    // - Log to analytics
    // - Show custom error widget
  }

  // Set up global error handling
  static void setupErrorHandling() {
    FlutterError.onError = handleError;

    // Handle errors that occur during the build phase
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return CustomErrorWidget(
        errorDetails: details,
        onRetry: () {
          // Force rebuild the widget tree
          WidgetsBinding.instance.performReassemble();
        },
      );
    };
  }

  // Handle specific types of errors
  static void handleNetworkError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lỗi kết nối: $message'),
        backgroundColor: Theme.of(context).colorScheme.error,
        action: SnackBarAction(
          label: 'Thử lại',
          textColor: Colors.white,
          onPressed: () {
            // Retry logic
          },
        ),
      ),
    );
  }

  static void handleValidationError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lỗi dữ liệu: $message'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  static void handleAuthError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lỗi xác thực: $message'),
        backgroundColor: Theme.of(context).colorScheme.error,
        action: SnackBarAction(
          label: 'Đăng nhập lại',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to login
          },
        ),
      ),
    );
  }

  // Show custom error dialog
  static void showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Đóng'),
              ),
              if (actionLabel != null && onAction != null)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onAction();
                  },
                  child: Text(actionLabel),
                ),
            ],
          ),
    );
  }

  // Show custom error bottom sheet
  static void showErrorBottomSheet(
    BuildContext context, {
    required String title,
    required String message,
    List<Widget>? actions,
  }) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                if (actions != null) ...[
                  const SizedBox(height: 24),
                  ...actions,
                ],
              ],
            ),
          ),
    );
  }

  // Copy error details to clipboard
  static void copyErrorToClipboard(String error) {
    Clipboard.setData(ClipboardData(text: error));
  }

  // Restart app (simplified)
  static void restartApp() {
    SystemNavigator.pop();
  }
}
