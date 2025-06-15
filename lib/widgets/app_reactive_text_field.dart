import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppReactiveTextField<T> extends StatefulWidget {
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
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final ControlValueAccessor<T, String>? valueAccessor;
  final void Function(FormControl<T>)? onChanged;
  final bool Function(FormControl<T>)? showErrors;
  final InputDecoration? decoration;

  final bool isCurrency;
  final String currencySymbol;

  AppReactiveTextField({
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
    this.maxLines,
    this.inputFormatters,
    this.onChanged,
    this.valueAccessor,
    this.showErrors,
    this.decoration,
  }) : isCurrency = false,
       currencySymbol = '' {
    assert(
      isCurrency == false || currencySymbol.isNotEmpty,
      'currencySymbol must be provided if isCurrency is true',
    );
  }

  AppReactiveTextField.currency({
    super.key,
    required this.label,
    required this.formControlName,
    this.controller,
    this.validationMessages,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.valueAccessor,
    this.showErrors,
    this.decoration,
  }) : isCurrency = true,
       keyboardType = TextInputType.numberWithOptions(decimal: false),
       obscureText = false,
       maxLength = null,
       maxLines = 1,
       inputFormatters = null,
       currencySymbol = '₫';

  @override
  State<AppReactiveTextField<T>> createState() => _AppReactiveTextField<T>();
}

class _AppReactiveTextField<T> extends State<AppReactiveTextField<T>> {
  @override
  Widget build(BuildContext context) {
    final inputFormatters =
        widget.isCurrency
            ? [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(
                trailingSymbol: widget.currencySymbol,
                useSymbolPadding: true,
                thousandSeparator: ThousandSeparator.Comma,
                mantissaLength: 0,
              ),
            ]
            : null;
    return ReactiveTextField<T>(
      formControlName: widget.formControlName,
      focusNode: widget.focusNode,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      showErrors: widget.showErrors,
      obscureText: widget.obscureText,
      maxLength: widget.maxLength,
      inputFormatters: inputFormatters,
      valueAccessor: widget.valueAccessor,
      decoration: widget.decoration ?? _buildDecoration(),
      validationMessages: widget.validationMessages,
      maxLines: widget.maxLines ?? 1,
      onChanged:
          widget.onChanged != null
              ? (control) => widget.onChanged!(control)
              : null,
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: widget.hintText,
      labelText: widget.label,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      fillColor: Colors.white,
    );
  }
}
