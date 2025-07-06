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
  String get agreement_message =>
      'Bằng cách tiếp tục, bạn đồng ý nhận cuộc gọi hoặc tin nhắn (bao gồm cả tự động) từ Hui App và các đối tác của nó. Phản hồi \"DỪNG\" bất kỳ lúc nào để hủy đăng ký.';

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
  String get text_message_info =>
      'Bạn sẽ nhận được tin nhắn trong vòng 20 giây.';

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
  String required_error(Object fieldName) {
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

  @override
  String get open_date => 'Ngày Khui';

  @override
  String get time_opened => 'Thời gian khui hụi';

  @override
  String get cycle_time => 'Thời gian mỗi chu kỳ';

  @override
  String get start_date => 'Ngày bắt đầu';

  @override
  String get end_date => 'Ngày kết thúc';

  @override
  String get choise_start_date_or_click_to_start =>
      'Chọn ngày bắt đầu hoặc nhấn để bắt đầu';

  @override
  String get hui_fund => 'Hụi Fund';

  @override
  String get no_groups_yet => 'Chưa có nhóm hụi nào';

  @override
  String get create_first_group_description =>
      'Tạo nhóm hụi đầu tiên để bắt đầu tiết kiệm và quản lý tài chính cùng bạn bè, gia đình';

  @override
  String get create_new_group => 'Tạo nhóm hụi mới';

  @override
  String get refresh => 'Làm mới';

  @override
  String get delete => 'Xóa';

  @override
  String get edit => 'Sửa';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get account => 'Tài khoản';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get security => 'Bảo mật';

  @override
  String get notifications => 'Thông báo';

  @override
  String get payment_methods => 'Phương thức thanh toán';

  @override
  String get transaction_history => 'Lịch sử giao dịch';

  @override
  String get help_support => 'Trợ giúp & Hỗ trợ';

  @override
  String get settings => 'Cài đặt';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get no_email_provided => 'Chưa cung cấp email';

  @override
  String get no_phone_provided => 'Chưa cung cấp số điện thoại';

  @override
  String get loading => 'Đang tải...';

  @override
  String get error => 'Lỗi';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get english => 'Tiếng Anh';

  @override
  String get home => 'Trang chủ';

  @override
  String get groups => 'Nhóm hụi';

  @override
  String get theme => 'Giao diện';

  @override
  String get light_mode => 'Chế độ sáng';

  @override
  String get dark_mode => 'Chế độ tối';

  @override
  String get system_mode => 'Theo hệ thống';

  @override
  String get light_dark => 'Sáng / Tối';

  @override
  String get group_information => 'Thông tin nhóm';

  @override
  String get fund_details => 'Chi tiết quỹ';

  @override
  String get privacy_and_automation => 'Riêng tư & Tự động hóa';

  @override
  String get save => 'Lưu';
}
