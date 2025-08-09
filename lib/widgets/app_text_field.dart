import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int? maxLength;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLength,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _showError = false; // Biến trạng thái để kiểm soát hiển thị lỗi
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: _controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.disabled, // Không tự động kiểm tra lỗi
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.label,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        errorText:
            _showError ? widget.validator?.call(_controller?.text) : null,
      ),
      onChanged: (value) {
        if (!_showError) {
          setState(() {
            _showError = true; // Hiển thị lỗi sau khi người dùng bắt đầu nhập
          });
        }
        widget.onChanged?.call(value);
      },
      onFieldSubmitted: (value) {
        setState(() {
          _showError = true; // Hiển thị lỗi khi người dùng nhấn Enter
        });
        widget.onFieldSubmitted?.call(value);
      },
    );
  }
}
