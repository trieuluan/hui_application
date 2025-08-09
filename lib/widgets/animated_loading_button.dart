import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AnimatedCircleButton extends StatefulWidget {
  final bool isLoading;
  final bool isSuccess;
  final void Function()? onPressed;
  final String title;
  final double? height;
  final double? width;

  const AnimatedCircleButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.title,
    this.isSuccess = false,
    this.height,
    this.width,
  });

  @override
  State<AnimatedCircleButton> createState() => _AnimatedCircleButtonState();
}

class _AnimatedCircleButtonState extends State<AnimatedCircleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late Animation<double> _paddingAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _widthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _paddingAnimation = Tween<double>(begin: 24.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(AnimatedCircleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading ||
        widget.isSuccess != oldWidget.isSuccess) {
      if (widget.isLoading || widget.isSuccess) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final maxWidth = widget.width ?? constraints.maxWidth;
            final buttonHeight = widget.height ?? 48.0;

            final currentWidth =
                maxWidth - (_widthAnimation.value * (maxWidth - buttonHeight));
            final currentPadding = _paddingAnimation.value;

            return SizedBox(
              width: currentWidth,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed:
                    (widget.isLoading || widget.isSuccess)
                        ? null
                        : widget.onPressed,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: currentPadding,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(buttonHeight / 2),
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: _buildChild(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChild() {
    if (widget.isLoading) {
      return SpinKitRing(
        key: const ValueKey('loading'),
        color: Theme.of(context).colorScheme.onPrimary,
        size: 24,
        lineWidth: 2,
      );
    } else if (widget.isSuccess) {
      return Icon(
        key: const ValueKey('success'),
        Icons.check,
        size: 24,
        color: Colors.green.shade500,
      );
    } else {
      return Text(
        key: const ValueKey('text'),
        widget.title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      );
    }
  }
}
