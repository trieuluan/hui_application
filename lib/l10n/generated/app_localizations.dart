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
  S(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
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
  /// **'By continuing, you agree to receive calls or messages (including automated) from Hui App and its partners. Reply “STOP” at any time to unsubscribe.'**
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
  String required_error(String fieldName);

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
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return SEn();
    case 'vi': return SVi();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
