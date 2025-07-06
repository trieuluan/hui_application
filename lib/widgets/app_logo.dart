import 'package:flutter/material.dart';
import 'package:hui_application/gen/assets.gen.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final Color? color;
  final bool showText;

  const AppLogo({super.key, this.size = 100, this.color, this.showText = true});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logoColor = color ?? theme.colorScheme.primaryContainer;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo Icon
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(size * 0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
              width: 1.2,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(size * 0.13),
            child: Image.asset(Assets.logoHui.path, fit: BoxFit.contain),
          ),
        ),

        if (showText) ...[
          const SizedBox(height: 16),
          // App Name
          Text(
            'Hui Fund',
            style: TextStyle(
              fontSize: size * 0.3,
              fontWeight: FontWeight.bold,
              color: logoColor,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          // Tagline
          Text(
            'Smart Group Savings',
            style: TextStyle(
              fontSize: size * 0.15,
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

// Animated Logo Version
class AnimatedAppLogo extends StatefulWidget {
  final double size;
  final Color? color;
  final bool showText;
  final Duration duration;

  const AnimatedAppLogo({
    super.key,
    this.size = 100,
    this.color,
    this.showText = true,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<AnimatedAppLogo> createState() => _AnimatedAppLogoState();
}

class _AnimatedAppLogoState extends State<AnimatedAppLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotateAnimation.value * 0.1,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: AppLogo(
                size: widget.size,
                color: widget.color,
                showText: widget.showText,
              ),
            ),
          ),
        );
      },
    );
  }
}
