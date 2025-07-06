import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AnimatedCircleButton extends StatefulWidget {
  final bool isLoading;
  final bool isSuccess;
  final void Function()? onPressed;
  final String title;

  const AnimatedCircleButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.title,
    this.isSuccess = false,
  });

  @override
  State<AnimatedCircleButton> createState() => _AnimatedCircleButtonState();
}

class _AnimatedCircleButtonState extends State<AnimatedCircleButton> {
  final GlobalKey _buttonKey = GlobalKey();

  double? _buttonHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _buttonHeight = _buttonKey.currentContext?.size?.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, constraints) => Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width:
                  widget.isLoading || widget.isSuccess
                      ? _buttonHeight
                      : constraints.maxWidth,
              // curve: Curves.easeInOut,
              child: ElevatedButton(
                key: _buttonKey,
                onPressed:
                    widget.isLoading || widget.isSuccess
                        ? null
                        : widget.onPressed,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.isLoading || widget.isSuccess ? 0 : 24,
                    vertical: 12,
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder:
                      (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                  child:
                      widget.isLoading
                          ? SpinKitRing(
                            color: Theme.of(context).colorScheme.primary,
                            size: 24,
                            lineWidth: 2,
                            key: ValueKey('loading'),
                          )
                          : widget.isSuccess
                          ? Icon(
                            Icons.check,
                            size: 24,
                            key: ValueKey('success'),
                            color: Colors.green.shade500,
                          )
                          : Text(
                            widget.title,
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
