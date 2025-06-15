import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CurrencyDoubleAccessor extends ControlValueAccessor<double, String> {
  final String symbol;

  CurrencyDoubleAccessor({this.symbol = '₫'});

  @override
  String? modelToViewValue(double? modelValue) {
    if (modelValue == null) return '';
    return toCurrencyString(
      modelValue.toString(),
      leadingSymbol: symbol,
      useSymbolPadding: true,
      thousandSeparator: ThousandSeparator.Comma,
      mantissaLength: 0,
    );
  }

  @override
  double? viewToModelValue(String? viewValue) {
    if (viewValue == null || viewValue.trim().isEmpty) return null;
    final numeric = viewValue.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(numeric);
  }
}
