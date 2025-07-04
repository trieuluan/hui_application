import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocaleUtilsIntl {
  // Sử dụng intl để format tên ngôn ngữ
  static String getLanguageDisplayName(
    String languageCode, [
    String? countryCode,
  ]) {
    return _getLanguageNameWithIntl(languageCode);
  }

  static String _getLanguageNameWithIntl(String languageCode) {
    try {
      // Sử dụng Intl.withLocale để set locale tạm thời
      return Intl.withLocale(languageCode, () {
        return _getLocalizedLanguageName(languageCode);
      });
    } catch (e) {
      // Fallback nếu có lỗi
      return _getFallbackLanguageName(languageCode);
    }
  }

  static String _getLocalizedLanguageName(String languageCode) {
    // Map tên ngôn ngữ theo từng locale
    const languageNames = {
      'vi': 'Tiếng Việt',
      'en': 'English',
      'zh': '中文',
      'ja': '日本語',
      'ko': '한국어',
      'fr': 'Français',
      'de': 'Deutsch',
      'es': 'Español',
      'it': 'Italiano',
      'pt': 'Português',
      'ru': 'Русский',
      'ar': 'العربية',
      'hi': 'हिन्दी',
      'th': 'ไทย',
      'id': 'Bahasa Indonesia',
      'ms': 'Bahasa Melayu',
      'tl': 'Tagalog',
      'my': 'မြန်မာ',
      'km': 'ខ្មែរ',
      'lo': 'ລາວ',
    };

    return languageNames[languageCode] ?? languageCode.toUpperCase();
  }

  static String _getFallbackLanguageName(String languageCode) {
    const languageNames = {
      'vi': 'Tiếng Việt',
      'en': 'English',
      'zh': '中文',
      'ja': '日本語',
      'ko': '한국어',
      'fr': 'Français',
      'de': 'Deutsch',
      'es': 'Español',
    };
    return languageNames[languageCode] ?? languageCode.toUpperCase();
  }

  // Sử dụng intl để format date/time theo locale
  static String formatDate(DateTime date, String languageCode) {
    try {
      return Intl.withLocale(languageCode, () {
        return DateFormat.yMMMd().format(date);
      });
    } catch (e) {
      // Fallback to default format
      return DateFormat.yMMMd().format(date);
    }
  }

  // Sử dụng intl để format number theo locale
  static String formatNumber(num number, String languageCode) {
    try {
      return Intl.withLocale(languageCode, () {
        return NumberFormat().format(number);
      });
    } catch (e) {
      // Fallback to default format
      return NumberFormat().format(number);
    }
  }

  // Sử dụng intl để format currency theo locale
  static String formatCurrency(
    num amount,
    String languageCode, [
    String? currencyCode,
  ]) {
    try {
      return Intl.withLocale(languageCode, () {
        return NumberFormat.currency(
          symbol: currencyCode ?? '\$',
          locale: languageCode,
        ).format(amount);
      });
    } catch (e) {
      // Fallback to default format
      return NumberFormat.currency(symbol: currencyCode ?? '\$').format(amount);
    }
  }

  // Lấy tên ngôn ngữ theo locale cụ thể (nâng cao)
  static String getLanguageDisplayNameForLocale(
    String languageCode,
    Locale displayLocale,
  ) {
    const languageNames = {
      'vi': {
        'vi': 'Tiếng Việt',
        'en': 'Vietnamese',
        'zh': '越南语',
        'ja': 'ベトナム語',
        'ko': '베트남어',
        'fr': 'Vietnamien',
        'de': 'Vietnamesisch',
        'es': 'Vietnamita',
      },
      'en': {
        'vi': 'Tiếng Anh',
        'en': 'English',
        'zh': '英语',
        'ja': '英語',
        'ko': '영어',
        'fr': 'Anglais',
        'de': 'Englisch',
        'es': 'Inglés',
      },
      'zh': {
        'vi': 'Tiếng Trung',
        'en': 'Chinese',
        'zh': '中文',
        'ja': '中国語',
        'ko': '중국어',
        'fr': 'Chinois',
        'de': 'Chinesisch',
        'es': 'Chino',
      },
    };

    final languageMap = languageNames[languageCode];
    if (languageMap != null) {
      return languageMap[displayLocale.languageCode] ??
          languageMap['en'] ??
          languageCode.toUpperCase();
    }

    return languageCode.toUpperCase();
  }

  // Sử dụng intl để pluralize
  static String pluralize(
    int count,
    String singular,
    String plural,
    String languageCode,
  ) {
    try {
      return Intl.withLocale(languageCode, () {
        return Intl.plural(count, one: singular, other: plural);
      });
    } catch (e) {
      // Fallback
      return count == 1 ? singular : plural;
    }
  }
}
