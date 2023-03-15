import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  static const Color scaffold = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF03648e);
  static const Color accent = Color(0xFF03648e);
  static const Color primaryTextColor = Color(0xFF333333);
  static const Color secondaryTextColor = Color(0xFF666666);
  static const Color appTitleTextColor = Color(0xFFFFFFFF);
  static const Color appTitleIconColor = Color(0xFFFFFFFF);
  static const Color primaryButtonTextColor = Color(0xFFFFFFFF);
}


getThemeDataTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: AppColor.scaffold,
    primaryColor: AppColor.primary,
    textTheme: GoogleFonts.montserratTextTheme(
      Theme.of(context).textTheme,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColor.primary,
      elevation: 0,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColor.accent),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: 14,
        letterSpacing: 1.5,
      ),
      contentPadding: EdgeInsets.all(12),
      isDense: true,
      border: OutlineInputBorder(),
      floatingLabelStyle: TextStyle(
        color: AppColor.primary,
        letterSpacing: 1.5,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.primary,
          width: 2,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColor.primary,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        onPrimary: AppColor.primaryButtonTextColor,
        elevation: 3,
        visualDensity: VisualDensity.compact,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        side: const BorderSide(color: Color.fromARGB(255, 3, 100, 142), width: 1),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: AppColor.primary,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        elevation: 3,
        visualDensity: VisualDensity.compact,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        side: const BorderSide(color: AppColor.primary, width: 1),
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColor.primary,
      size: 24,
    ),
    dialogTheme: DialogTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
