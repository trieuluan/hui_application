import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry? padding;
  final Color? labelColor;
  final BorderRadius? borderRadius;

  const CustomChip({
    super.key,
    required this.label,
    this.borderRadius,
    this.backgroundColor,
    this.labelPadding,
    this.padding,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: labelColor ?? Color(0xFF00835E)),
      ),
      backgroundColor: backgroundColor ?? Color(0xFFCAF5EB),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
      ),
      labelPadding:
          labelPadding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      padding: padding ?? EdgeInsets.all(0),
    );
  }
}
