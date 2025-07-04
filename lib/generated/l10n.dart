// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Get started with\nHui Fund`
  String get get_start {
    return Intl.message(
      'Get started with\nHui Fund',
      name: 'get_start',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get phone_placeholder {
    return Intl.message(
      'Enter phone number',
      name: 'phone_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_ {
    return Intl.message('Continue', name: 'continue_', desc: '', args: []);
  }

  /// `Continue with Facebook`
  String get continue_facebook {
    return Intl.message(
      'Continue with Facebook',
      name: 'continue_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continue_google {
    return Intl.message(
      'Continue with Google',
      name: 'continue_google',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get phone_number_error {
    return Intl.message(
      'Invalid phone number',
      name: 'phone_number_error',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get phone_number_empty {
    return Intl.message(
      'Please enter phone number',
      name: 'phone_number_empty',
      desc: '',
      args: [],
    );
  }

  /// `By continuing, you agree to receive calls or messages (including automated) from Hui App and its partners. Reply "STOP" at any time to unsubscribe.`
  String get agreement_message {
    return Intl.message(
      'By continuing, you agree to receive calls or messages (including automated) from Hui App and its partners. Reply "STOP" at any time to unsubscribe.',
      name: 'agreement_message',
      desc: '',
      args: [],
    );
  }

  /// `Protected by reCAPTCHA: Google `
  String get recaptcha_protected {
    return Intl.message(
      'Protected by reCAPTCHA: Google ',
      name: 'recaptcha_protected',
      desc: '',
      args: [],
    );
  }

  /// `Policy`
  String get google_policy {
    return Intl.message('Policy', name: 'google_policy', desc: '', args: []);
  }

  /// `Terms`
  String get google_terms {
    return Intl.message('Terms', name: 'google_terms', desc: '', args: []);
  }

  /// `and`
  String get and {
    return Intl.message('and', name: 'and', desc: '', args: []);
  }

  /// `Enter the 4 digit code\nsent to you at`
  String get enter_code_message {
    return Intl.message(
      'Enter the 4 digit code\nsent to you at',
      name: 'enter_code_message',
      desc: '',
      args: [],
    );
  }

  /// `Change phone number`
  String get change_number {
    return Intl.message(
      'Change phone number',
      name: 'change_number',
      desc: '',
      args: [],
    );
  }

  /// `Verification code sent to phone`
  String get verification_code_sent {
    return Intl.message(
      'Verification code sent to phone',
      name: 'verification_code_sent',
      desc: '',
      args: [],
    );
  }

  /// `You should get a text within 20 seconds.`
  String get text_message_info {
    return Intl.message(
      'You should get a text within 20 seconds.',
      name: 'text_message_info',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get resend_code {
    return Intl.message('Resend code', name: 'resend_code', desc: '', args: []);
  }

  /// `Enter your Password`
  String get enter_password {
    return Intl.message(
      'Enter your Password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is invalid`
  String get phone_number_invalid {
    return Intl.message(
      'Phone number is invalid',
      name: 'phone_number_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Phone number not found`
  String get phone_number_not_found {
    return Intl.message(
      'Phone number not found',
      name: 'phone_number_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Phone number cannot be empty`
  String get phone_number_cannot_be_empty {
    return Intl.message(
      'Phone number cannot be empty',
      name: 'phone_number_cannot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Password cannot be empty`
  String get password_empty {
    return Intl.message(
      'Password cannot be empty',
      name: 'password_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password is invalid`
  String get password_invalid {
    return Intl.message(
      'Password is invalid',
      name: 'password_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Password not found`
  String get password_not_found {
    return Intl.message(
      'Password not found',
      name: 'password_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get password_not_match {
    return Intl.message(
      'Password does not match',
      name: 'password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Group created successfully`
  String get group_created_successfully {
    return Intl.message(
      'Group created successfully',
      name: 'group_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Create a new Hui Fund`
  String get create_hui_fund {
    return Intl.message(
      'Create a new Hui Fund',
      name: 'create_hui_fund',
      desc: '',
      args: [],
    );
  }

  /// `Name of Hui`
  String get name_of_hui {
    return Intl.message('Name of Hui', name: 'name_of_hui', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Amount per cycle`
  String get amount_per_cycle {
    return Intl.message(
      'Amount per cycle',
      name: 'amount_per_cycle',
      desc: '',
      args: [],
    );
  }

  /// `Total cycles`
  String get total_cycles {
    return Intl.message(
      'Total cycles',
      name: 'total_cycles',
      desc: '',
      args: [],
    );
  }

  /// `Maximum members`
  String get maximum_members {
    return Intl.message(
      'Maximum members',
      name: 'maximum_members',
      desc: '',
      args: [],
    );
  }

  /// `Duration cycle`
  String get duration_cycle {
    return Intl.message(
      'Duration cycle',
      name: 'duration_cycle',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message('Day', name: 'day', desc: '', args: []);
  }

  /// `Week`
  String get week {
    return Intl.message('Week', name: 'week', desc: '', args: []);
  }

  /// `Month`
  String get month {
    return Intl.message('Month', name: 'month', desc: '', args: []);
  }

  /// `Year`
  String get year {
    return Intl.message('Year', name: 'year', desc: '', args: []);
  }

  /// `{fieldName} is required`
  String required_error(Object fieldName) {
    return Intl.message(
      '$fieldName is required',
      name: 'required_error',
      desc: '',
      args: [fieldName],
    );
  }

  /// `{fieldName} is invalid`
  String invalid_error(Object fieldName) {
    return Intl.message(
      '$fieldName is invalid',
      name: 'invalid_error',
      desc: '',
      args: [fieldName],
    );
  }

  /// `Private group`
  String get private_group {
    return Intl.message(
      'Private group',
      name: 'private_group',
      desc: '',
      args: [],
    );
  }

  /// `Auto start when member full`
  String get auto_start_when_member_full {
    return Intl.message(
      'Auto start when member full',
      name: 'auto_start_when_member_full',
      desc: '',
      args: [],
    );
  }

  /// `Open date`
  String get open_date {
    return Intl.message('Open date', name: 'open_date', desc: '', args: []);
  }

  /// `Time opened`
  String get time_opened {
    return Intl.message('Time opened', name: 'time_opened', desc: '', args: []);
  }

  /// `Cycle time`
  String get cycle_time {
    return Intl.message('Cycle time', name: 'cycle_time', desc: '', args: []);
  }

  /// `Start date`
  String get start_date {
    return Intl.message('Start date', name: 'start_date', desc: '', args: []);
  }

  /// `End date`
  String get end_date {
    return Intl.message('End date', name: 'end_date', desc: '', args: []);
  }

  /// `Choose start date or click to start`
  String get choise_start_date_or_click_to_start {
    return Intl.message(
      'Choose start date or click to start',
      name: 'choise_start_date_or_click_to_start',
      desc: '',
      args: [],
    );
  }

  /// `Hui Fund`
  String get hui_fund {
    return Intl.message('Hui Fund', name: 'hui_fund', desc: '', args: []);
  }

  /// `No groups yet`
  String get no_groups_yet {
    return Intl.message(
      'No groups yet',
      name: 'no_groups_yet',
      desc: '',
      args: [],
    );
  }

  /// `Create your first group to start saving and managing finances with friends and family`
  String get create_first_group_description {
    return Intl.message(
      'Create your first group to start saving and managing finances with friends and family',
      name: 'create_first_group_description',
      desc: '',
      args: [],
    );
  }

  /// `Create new group`
  String get create_new_group {
    return Intl.message(
      'Create new group',
      name: 'create_new_group',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Security`
  String get security {
    return Intl.message('Security', name: 'security', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Payment Methods`
  String get payment_methods {
    return Intl.message(
      'Payment Methods',
      name: 'payment_methods',
      desc: '',
      args: [],
    );
  }

  /// `Transaction History`
  String get transaction_history {
    return Intl.message(
      'Transaction History',
      name: 'transaction_history',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get help_support {
    return Intl.message(
      'Help & Support',
      name: 'help_support',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `No email provided`
  String get no_email_provided {
    return Intl.message(
      'No email provided',
      name: 'no_email_provided',
      desc: '',
      args: [],
    );
  }

  /// `No phone number provided`
  String get no_phone_provided {
    return Intl.message(
      'No phone number provided',
      name: 'no_phone_provided',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Vietnamese`
  String get vietnamese {
    return Intl.message('Vietnamese', name: 'vietnamese', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Groups`
  String get groups {
    return Intl.message('Groups', name: 'groups', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Light Mode`
  String get light_mode {
    return Intl.message('Light Mode', name: 'light_mode', desc: '', args: []);
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message('Dark Mode', name: 'dark_mode', desc: '', args: []);
  }

  /// `System Mode`
  String get system_mode {
    return Intl.message('System Mode', name: 'system_mode', desc: '', args: []);
  }

  /// `Light / Dark`
  String get light_dark {
    return Intl.message('Light / Dark', name: 'light_dark', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
