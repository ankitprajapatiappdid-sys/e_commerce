import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = const Color(0xFF644D9F);
Color secondaryColor = const Color(0xFFF5F0BB);
Color backgroundDark = const Color(0xff231F20);
Color backgroundLight = const Color(0xffffffff);
const Color textPrimary = Color(0xff000000);
const Color textSecondary = Color(0xff292929);

Color black=const Color(0xFF000000);

class CustomTheme {
  static ThemeData light = ThemeData(
    fontFamily: "Poppins",
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundLight,
    hintColor: Colors.grey[700],
    canvasColor: secondaryColor,
    primaryColorLight: secondaryColor,
    splashColor: secondaryColor,
    shadowColor: Colors.grey[600],
    cardColor: Colors.grey[100],
    primaryColor: primaryColor,
    dividerColor: Colors.grey[600],
    primaryColorDark: Colors.black,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: secondaryColor,
      onSecondary: Colors.black,
      error: const Color(0xFFCF6679),
      onError: const Color(0xFFCF6679),
      surface: backgroundLight,
      onSurface: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      actionsIconTheme: IconThemeData(color: backgroundLight),
      iconTheme: IconThemeData(color: backgroundLight),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light),
    ),
    typography: Typography.material2021(),
    textTheme: TextTheme(
      labelLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        color: textSecondary,
        fontSize: 14.0,
      ),
      labelMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        color: textSecondary,
        fontSize: 12.0,
      ),
      labelSmall: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        color: textSecondary,
        fontSize: 11.0,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
        color: textSecondary,
        fontSize: 32.0,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        color: textSecondary,
        fontSize: 28.0,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        color: textSecondary,
        fontSize: 24.0,
      ),
      displayLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
        color: textSecondary,
        fontSize: 57.0,
      ),
      displayMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        color: textSecondary,
        fontSize: 45.0,
      ),
      displaySmall: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        color: textSecondary,
        fontSize: 36.0,
      ),
      titleLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        color: textSecondary,
        fontSize: 22.0,
      ),
      titleMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        color: textSecondary,
        fontSize: 16.0,
      ),
      titleSmall: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        color: textSecondary,
        fontSize: 14.0,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        color: textSecondary,
        fontSize: 16.0,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        color: textSecondary,
        fontSize: 14.0,
      ),
      bodySmall: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        color: textSecondary,
        fontSize: 12.0,
      ),
    ),
  );
}
