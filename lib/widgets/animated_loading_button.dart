import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AnimatedCircleButton extends StatelessWidget {
  final bool isLoading;
  final bool isSuccess;
  final void Function()? onPressed;
  final String title;
  final double buttonHeight;

  const AnimatedCircleButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.title,
    this.isSuccess = false,
    this.buttonHeight = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, constraints) => Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width:
                  isLoading || isSuccess ? buttonHeight : constraints.maxWidth,
              height: buttonHeight,
              curve: Curves.easeInOut,
              child: ElevatedButton(
                onPressed: isLoading || isSuccess ? null : onPressed,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                  child:
                      isLoading
                          ? const SpinKitRing(
                            color: Colors.white,
                            size: 24,
                            lineWidth: 2,
                            key: ValueKey('loading'),
                          )
                          : isSuccess
                          ? Icon(
                            Icons.check,
                            key: ValueKey('success'),
                            color: Colors.green.shade500,
                          )
                          : Text(
                            title,
                            key: ValueKey('text'),
                            style: const TextStyle(fontSize: 16),
                          ),
                ),
              ),
            ),
          ),
    );
  }
}
