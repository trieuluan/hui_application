import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatDate() {
    return '$day/$month/$year';
  }

  String formatTime() {
    return '$hour:$minute';
  }

  String formatDateTime() {
    return '${formatDate()} ${formatTime()}';
  }

  String format(String format) {
    return DateFormat(format).format(this);
  }

  /// 28/05/2024
  String get ddMMyyyy => DateFormat('dd/MM/yyyy').format(this);

  /// 28 tháng 5, 2024
  String get viLong => DateFormat("d 'tháng' M, y", 'vi_VN').format(this);

  /// Thứ Ba, 28/05/2024
  String get viFull => DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(this);

  /// Thời gian chi tiết: 28/05/2024 11:30
  String get fullWithHour =>
      DateFormat('dd/MM/yyyy HH:mm', 'vi_VN').format(this);
}
