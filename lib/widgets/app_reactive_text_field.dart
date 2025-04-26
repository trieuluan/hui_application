import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppReactiveTextField extends StatefulWidget {
  final String formControlName;
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final Map<String, String Function(Object)>? validationMessages;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int? maxLength;
  final FocusNode? focusNode;

  const AppReactiveTextField({
    super.key,
    required this.label,
    required this.formControlName,
    this.controller,
    this.validationMessages,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLength,
    this.focusNode,
    this.hintText,
  });

  @override
  State<AppReactiveTextField> createState() => _AppReactiveTextField();
}

class _AppReactiveTextField extends State<AppReactiveTextField> {
  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: widget.formControlName,
      focusNode: widget.focusNode,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.label,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      validationMessages: widget.validationMessages,
    );
  }
}
