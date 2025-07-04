import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @get_start.
  ///
  /// In en, this message translates to:
  /// **'Get started with\nHui Fund'**
  String get get_start;

  /// No description provided for @phone_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get phone_placeholder;

  /// No description provided for @continue_.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_;

  /// No description provided for @continue_facebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get continue_facebook;

  /// No description provided for @continue_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continue_google;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_number;

  /// No description provided for @phone_number_error.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get phone_number_error;

  /// No description provided for @phone_number_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get phone_number_empty;

  /// No description provided for @agreement_message.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to receive calls or messages (including automated) from Hui App and its partners. Reply \"STOP\" at any time to unsubscribe.'**
  String get agreement_message;

  /// No description provided for @recaptcha_protected.
  ///
  /// In en, this message translates to:
  /// **'Protected by reCAPTCHA: Google '**
  String get recaptcha_protected;

  /// No description provided for @google_policy.
  ///
  /// In en, this message translates to:
  /// **'Policy'**
  String get google_policy;

  /// No description provided for @google_terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get google_terms;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @enter_code_message.
  ///
  /// In en, this message translates to:
  /// **'Enter the 4 digit code\nsent to you at'**
  String get enter_code_message;

  /// No description provided for @change_number.
  ///
  /// In en, this message translates to:
  /// **'Change phone number'**
  String get change_number;

  /// No description provided for @verification_code_sent.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to phone'**
  String get verification_code_sent;

  /// No description provided for @text_message_info.
  ///
  /// In en, this message translates to:
  /// **'You should get a text within 20 seconds.'**
  String get text_message_info;

  /// No description provided for @resend_code.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resend_code;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your Password'**
  String get enter_password;

  /// No description provided for @phone_number_invalid.
  ///
  /// In en, this message translates to:
  /// **'Phone number is invalid'**
  String get phone_number_invalid;

  /// No description provided for @phone_number_not_found.
  ///
  /// In en, this message translates to:
  /// **'Phone number not found'**
  String get phone_number_not_found;

  /// No description provided for @phone_number_cannot_be_empty.
  ///
  /// In en, this message translates to:
  /// **'Phone number cannot be empty'**
  String get phone_number_cannot_be_empty;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @password_empty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get password_empty;

  /// No description provided for @password_invalid.
  ///
  /// In en, this message translates to:
  /// **'Password is invalid'**
  String get password_invalid;

  /// No description provided for @password_not_found.
  ///
  /// In en, this message translates to:
  /// **'Password not found'**
  String get password_not_found;

  /// No description provided for @password_not_match.
  ///
  /// In en, this message translates to:
  /// **'Password does not match'**
  String get password_not_match;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @group_created_successfully.
  ///
  /// In en, this message translates to:
  /// **'Group created successfully'**
  String get group_created_successfully;

  /// No description provided for @create_hui_fund.
  ///
  /// In en, this message translates to:
  /// **'Create a new Hui Fund'**
  String get create_hui_fund;

  /// No description provided for @name_of_hui.
  ///
  /// In en, this message translates to:
  /// **'Name of Hui'**
  String get name_of_hui;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @amount_per_cycle.
  ///
  /// In en, this message translates to:
  /// **'Amount per cycle'**
  String get amount_per_cycle;

  /// No description provided for @total_cycles.
  ///
  /// In en, this message translates to:
  /// **'Total cycles'**
  String get total_cycles;

  /// No description provided for @maximum_members.
  ///
  /// In en, this message translates to:
  /// **'Maximum members'**
  String get maximum_members;

  /// No description provided for @duration_cycle.
  ///
  /// In en, this message translates to:
  /// **'Duration cycle'**
  String get duration_cycle;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @required_error.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} is required'**
  String required_error(Object fieldName);

  /// No description provided for @invalid_error.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} is invalid'**
  String invalid_error(Object fieldName);

  /// No description provided for @private_group.
  ///
  /// In en, this message translates to:
  /// **'Private group'**
  String get private_group;

  /// No description provided for @auto_start_when_member_full.
  ///
  /// In en, this message translates to:
  /// **'Auto start when member full'**
  String get auto_start_when_member_full;

  /// No description provided for @open_date.
  ///
  /// In en, this message translates to:
  /// **'Open date'**
  String get open_date;

  /// No description provided for @time_opened.
  ///
  /// In en, this message translates to:
  /// **'Time opened'**
  String get time_opened;

  /// No description provided for @cycle_time.
  ///
  /// In en, this message translates to:
  /// **'Cycle time'**
  String get cycle_time;

  /// No description provided for @start_date.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get start_date;

  /// No description provided for @end_date.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get end_date;

  /// No description provided for @choise_start_date_or_click_to_start.
  ///
  /// In en, this message translates to:
  /// **'Choose start date or click to start'**
  String get choise_start_date_or_click_to_start;

  /// No description provided for @hui_fund.
  ///
  /// In en, this message translates to:
  /// **'Hui Fund'**
  String get hui_fund;

  /// No description provided for @no_groups_yet.
  ///
  /// In en, this message translates to:
  /// **'No groups yet'**
  String get no_groups_yet;

  /// No description provided for @create_first_group_description.
  ///
  /// In en, this message translates to:
  /// **'Create your first group to start saving and managing finances with friends and family'**
  String get create_first_group_description;

  /// No description provided for @create_new_group.
  ///
  /// In en, this message translates to:
  /// **'Create new group'**
  String get create_new_group;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @payment_methods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get payment_methods;

  /// No description provided for @transaction_history.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transaction_history;

  /// No description provided for @help_support.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get help_support;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @no_email_provided.
  ///
  /// In en, this message translates to:
  /// **'No email provided'**
  String get no_email_provided;

  /// No description provided for @no_phone_provided.
  ///
  /// In en, this message translates to:
  /// **'No phone number provided'**
  String get no_phone_provided;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @groups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get groups;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get light_mode;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @system_mode.
  ///
  /// In en, this message translates to:
  /// **'System Mode'**
  String get system_mode;

  /// No description provided for @light_dark.
  ///
  /// In en, this message translates to:
  /// **'Light / Dark'**
  String get light_dark;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'vi':
      return SVi();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
