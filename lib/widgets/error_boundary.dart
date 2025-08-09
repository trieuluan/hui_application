import 'package:flutter/material.dart';
import 'package:hui_application/widgets/custom_error_widget.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(FlutterErrorDetails)? errorBuilder;
  final VoidCallback? onError;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
    this.onError,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  FlutterErrorDetails? _errorDetails;

  @override
  Widget build(BuildContext context) {
    if (_errorDetails != null) {
      return widget.errorBuilder?.call(_errorDetails!) ??
          CustomErrorWidget(errorDetails: _errorDetails!, onRetry: _retry);
    }

    return widget.child;
  }

  void _retry() {
    setState(() {
      _errorDetails = null;
    });
  }

  @override
  void initState() {
    super.initState();
    // Set up error handling for this widget tree
    FlutterError.onError = (FlutterErrorDetails details) {
      setState(() {
        _errorDetails = details;
      });
      widget.onError?.call();
    };
  }
}

// Convenience widget for wrapping specific sections
class ErrorBoundarySection extends StatelessWidget {
  final Widget child;
  final String sectionName;
  final VoidCallback? onRetry;

  const ErrorBoundarySection({
    super.key,
    required this.child,
    required this.sectionName,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      onError: () {
        // Log section-specific error
        debugPrint('Error in section: $sectionName');
      },
      errorBuilder:
          (details) => Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).colorScheme.error),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 8),
                Text(
                  'Lỗi trong $sectionName',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Phần này gặp sự cố. Vui lòng thử lại.',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onRetry,
                    child: const Text('Thử lại'),
                  ),
                ],
              ],
            ),
          ),
      child: child,
    );
  }
}
