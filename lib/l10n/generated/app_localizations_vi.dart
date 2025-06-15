// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class SVi extends S {
  SVi([String locale = 'vi']) : super(locale);

  @override
  String get get_start => 'Bắt đầu với\nHui Fund';

  @override
  String get phone_placeholder => 'Nhập số điện thoại';

  @override
  String get continue_ => 'Tiếp tục';

  @override
  String get continue_facebook => 'Tiếp tục với Facebook';

  @override
  String get continue_google => 'Tiếp tục với Google';

  @override
  String get phone_number => 'Số điện thoại';

  @override
  String get phone_number_error => 'Số điện thoại không hợp lệ';

  @override
  String get phone_number_empty => 'Vui lòng nhập số điện thoại';

  @override
  String get agreement_message => 'Bằng cách tiếp tục, bạn đồng ý nhận cuộc gọi hoặc tin nhắn (bao gồm cả tự động) từ Hui App và các đối tác của nó. Phản hồi “DỪNG” bất kỳ lúc nào để hủy đăng ký.';

  @override
  String get recaptcha_protected => 'Được bảo vệ bởi reCAPTCHA: Google ';

  @override
  String get google_policy => 'Chính sách';

  @override
  String get google_terms => 'Điều khoản';

  @override
  String get and => 'và';

  @override
  String get enter_code_message => 'Nhập mã 4 chữ số\nđã gửi cho bạn tại';

  @override
  String get change_number => 'Thay đổi số điện thoại';

  @override
  String get verification_code_sent => 'Mã xác minh đã gửi đến điện thoại';

  @override
  String get text_message_info => 'Bạn sẽ nhận được tin nhắn trong vòng 20 giây.';

  @override
  String get resend_code => 'Gửi lại mã';

  @override
  String get enter_password => 'Nhập mật khẩu của bạn';

  @override
  String get phone_number_invalid => 'Số điện thoại không hợp lệ';

  @override
  String get phone_number_not_found => 'Số điện thoại không tìm thấy';

  @override
  String get phone_number_cannot_be_empty => 'Số điện thoại không thể để trống';

  @override
  String get password => 'Mật khẩu';

  @override
  String get password_empty => 'Mật khẩu không thể để trống';

  @override
  String get password_invalid => 'Mật khẩu không hợp lệ';

  @override
  String get password_not_found => 'Mật khẩu không tìm thấy';

  @override
  String get password_not_match => 'Mật khẩu không khớp';

  @override
  String get login => 'Đăng nhập';

  @override
  String get group_created_successfully => 'Nhóm Hụi đã được tạo thành công';

  @override
  String get create_hui_fund => 'Tạo một Hụi Fund mới';

  @override
  String get name_of_hui => 'Tên của Hụi';

  @override
  String get description => 'Mô tả';

  @override
  String get amount_per_cycle => 'Số tiền mỗi kỳ';

  @override
  String get total_cycles => 'Tổng số kỳ';

  @override
  String get maximum_members => 'Thành viên tối đa';

  @override
  String get duration_cycle => 'Thời gian mỗi kỳ';

  @override
  String get day => 'Ngày';

  @override
  String get week => 'Tuần';

  @override
  String get month => 'Tháng';

  @override
  String get year => 'Năm';

  @override
  String required_error(String fieldName) {
    return '$fieldName là bắt buộc';
  }

  @override
  String invalid_error(Object fieldName) {
    return '$fieldName không hợp lệ';
  }

  @override
  String get private_group => 'Nhóm riêng tư';

  @override
  String get auto_start_when_member_full => 'Tự động bắt đầu khi đủ thành viên';
}
