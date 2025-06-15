extension PhoneUtilsExtension on String {
  /// Mask số điện thoại, chỉ hiện 2 số cuối
  String maskLastTwoDigits() {
    if (length < 2) return this;
    final lastTwo = substring(length - 2);
    return '*' * (length - 2) + lastTwo;
  }

  /// Mask số điện thoại, chỉ hiện 4 số cuối
  String maskLastFourDigits() {
    if (length < 4) return this;
    final lastFour = substring(length - 4);
    return '*' * (length - 4) + lastFour;
  }

  /// Format số điện thoại Việt Nam: +84 912 345 678
  String formatPhoneNumberVN() {
    var cleaned = replaceAll(RegExp(r'\D'), '');

    if (cleaned.startsWith('0')) {
      cleaned = '84${cleaned.substring(1)}';
    }
    if (!cleaned.startsWith('84')) {
      cleaned = '84$cleaned';
    }

    if (cleaned.length < 11) {
      return '+$cleaned'; // fallback nếu ngắn
    }

    return '+${cleaned.substring(0, 2)} ${cleaned.substring(2, 5)} ${cleaned.substring(5, 8)} ${cleaned.substring(8)}';
  }

  String maskMiddleOfPhoneNumber({int startVisible = 2, int endVisible = 3}) {
    if (length <= startVisible + endVisible) {
      return this; // Nếu quá ngắn thì trả lại như cũ
    }
    final start = substring(0, startVisible);
    final end = substring(length - endVisible);
    final maskedLength = length - startVisible - endVisible;
    final masked = '*' * maskedLength;
    return '$start$masked$end';
  }
}
