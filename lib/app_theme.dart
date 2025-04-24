import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2B46F9);
  static const Color backgroundColor = Colors.white;
  static const Color inputFillColor = Color(0xFFF7F8F9);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color textColor = Color(0xFF111827);
  static const Color subtitleColor = Color(0xFF6B7280);
  static const Color socialButtonColor = Color(0xFFF3F4F6);

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'BeVietnamPro',
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor,
      brightness: Brightness.light,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputFillColor,
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textColor, fontSize: 18),
      bodyMedium: TextStyle(color: textColor),
      bodySmall: TextStyle(color: subtitleColor),
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
      labelLarge: TextStyle(color: subtitleColor),
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFFE5E7EB)),
    iconTheme: const IconThemeData(color: textColor),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
