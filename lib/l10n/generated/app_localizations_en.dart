// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get get_start => 'Get started with\nHui Fund';

  @override
  String get phone_placeholder => 'Enter phone number';

  @override
  String get continue_ => 'Continue';

  @override
  String get continue_facebook => 'Continue with Facebook';

  @override
  String get continue_google => 'Continue with Google';

  @override
  String get phone_number => 'Phone number';

  @override
  String get phone_number_error => 'Invalid phone number';

  @override
  String get phone_number_empty => 'Please enter phone number';

  @override
  String get agreement_message => 'By continuing, you agree to receive calls or messages (including automated) from Hui App and its partners. Reply “STOP” at any time to unsubscribe.';

  @override
  String get recaptcha_protected => 'Protected by reCAPTCHA: Google ';

  @override
  String get google_policy => 'Policy';

  @override
  String get google_terms => 'Terms';

  @override
  String get and => 'and';

  @override
  String get enter_code_message => 'Enter the 4 digit code\nsent to you at';

  @override
  String get change_number => 'Change phone number';

  @override
  String get verification_code_sent => 'Verification code sent to phone';

  @override
  String get text_message_info => 'You should get a text within 20 seconds.';

  @override
  String get resend_code => 'Resend code';

  @override
  String get enter_password => 'Enter your Password';

  @override
  String get phone_number_invalid => 'Phone number is invalid';

  @override
  String get phone_number_not_found => 'Phone number not found';

  @override
  String get phone_number_cannot_be_empty => 'Phone number cannot be empty';

  @override
  String get password => 'Password';

  @override
  String get password_empty => 'Password cannot be empty';

  @override
  String get password_invalid => 'Password is invalid';

  @override
  String get password_not_found => 'Password not found';

  @override
  String get password_not_match => 'Password does not match';

  @override
  String get login => 'Login';

  @override
  String get group_created_successfully => 'Group created successfully';

  @override
  String get create_hui_fund => 'Create a new Hui Fund';

  @override
  String get name_of_hui => 'Name of Hui';

  @override
  String get description => 'Description';

  @override
  String get amount_per_cycle => 'Amount per cycle';

  @override
  String get total_cycles => 'Total cycles';

  @override
  String get maximum_members => 'Maximum members';

  @override
  String get duration_cycle => 'Duration cycle';

  @override
  String get day => 'Day';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String required_error(String fieldName) {
    return '$fieldName is required';
  }

  @override
  String invalid_error(Object fieldName) {
    return '$fieldName is invalid';
  }

  @override
  String get private_group => 'Private group';

  @override
  String get auto_start_when_member_full => 'Auto start when member full';
}
