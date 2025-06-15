import 'package:intl/intl.dart';

extension NumExtension on num {
  /// Chuyển đổi số thành chuỗi với định dạng tiền tệ
  String toCurrencyString() {
    return toStringAsFixed(
      0,
    ).replaceAllMapped(RegExp(r'(\d+)(\d{3})'), (Match m) => '${m[1]},${m[2]}');
  }

  /// Chuyển đổi số thành chuỗi với định dạng phần trăm
  String toPercentString() {
    return '${(this * 100).toStringAsFixed(0)}%';
  }

  /// Format như: 1.250.000 đồng
  String get toVNDWithDong =>
      '${NumberFormat.decimalPattern('vi_VN').format(this)}đồng';

  /// Format như: 1.250.000 VNĐ
  String get toVNDWithVND =>
      NumberFormat.currency(locale: 'vi_VN', symbol: 'VND').format(this);

  /// Format như: 1.250.000 ₫
  String get toVNDWithSymbol =>
      '${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(this)}₫';
}
