extension StringExtension on String {
  /// Chuyển đổi chuỗi thành số nguyên
  int toInt() {
    return int.tryParse(this) ?? 0;
  }

  /// Chuyển đổi chuỗi thành số thực
  double toDouble() {
    return double.tryParse(this) ?? 0.0;
  }

  /// Kiểm tra xem chuỗi có phải là số hay không
  bool isNumeric() {
    return RegExp(r'^-?[0-9]+$').hasMatch(this);
  }

  /// Kiểm tra xem chuỗi có phải là số thực hay không
  bool isDouble() {
    return RegExp(r'^-?[0-9]+(\.[0-9]+)?$').hasMatch(this);
  }

  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
