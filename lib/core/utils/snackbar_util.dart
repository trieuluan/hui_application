import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

// Hàm thông báo lỗi hiện đại
void showGlobalErrorSnackBar({
  required String message,
  Duration duration = const Duration(seconds: 4),
  String? title,
}) {
  BotToast.showAnimationWidget(
    toastBuilder:
        (cancelFunc) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _ModernErrorToast(
              message: message,
              title: title,
              onClose: cancelFunc,
            ),
          ),
        ),
    animationDuration: const Duration(milliseconds: 300),
    duration: duration,
    crossPage: true,
    onlyOne: false,
  );
}

// Hàm thông báo thành công hiện đại
void showGlobalSuccessSnackBar({
  required String message,
  Duration duration = const Duration(seconds: 4),
  String? title,
}) {
  BotToast.showAnimationWidget(
    toastBuilder:
        (cancelFunc) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _ModernSuccessToast(
              message: message,
              title: title,
              onClose: cancelFunc,
            ),
          ),
        ),
    animationDuration: const Duration(milliseconds: 300),
    duration: duration,
    crossPage: true,
    onlyOne: false,
  );
}

// Hàm thông báo thông tin hiện đại
void showGlobalInfoSnackBar({
  required String message,
  Duration duration = const Duration(seconds: 4),
  String? title,
}) {
  BotToast.showAnimationWidget(
    toastBuilder:
        (cancelFunc) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _ModernInfoToast(
              message: message,
              title: title,
              onClose: cancelFunc,
            ),
          ),
        ),
    animationDuration: const Duration(milliseconds: 300),
    duration: duration,
    crossPage: true,
    onlyOne: false,
  );
}

// Hàm thông báo cảnh báo hiện đại
void showGlobalWarningSnackBar({
  required String message,
  Duration duration = const Duration(seconds: 4),
  String? title,
}) {
  BotToast.showAnimationWidget(
    toastBuilder:
        (cancelFunc) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _ModernWarningToast(
              message: message,
              title: title,
              onClose: cancelFunc,
            ),
          ),
        ),
    animationDuration: const Duration(milliseconds: 300),
    duration: duration,
    crossPage: true,
    onlyOne: false,
  );
}

// Widget Toast lỗi hiện đại
class _ModernErrorToast extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback onClose;

  const _ModernErrorToast({
    required this.message,
    this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.onErrorContainer,
              size: 20,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onErrorContainer,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Toast thành công hiện đại
class _ModernSuccessToast extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback onClose;

  const _ModernSuccessToast({
    required this.message,
    this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              size: 20,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Toast thông tin hiện đại
class _ModernInfoToast extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback onClose;

  const _ModernInfoToast({
    required this.message,
    this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              size: 20,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Toast cảnh báo hiện đại
class _ModernWarningToast extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback onClose;

  const _ModernWarningToast({
    required this.message,
    this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_outlined,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
              size: 20,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onTertiaryContainer,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
