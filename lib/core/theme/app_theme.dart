import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

/// Application-wide theme data following the Midnight Navy & Silver palette.
abstract final class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.midnightNavy,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.silver,
        secondary: AppColors.subtitleBlue,
        surface: AppColors.midnightNavy,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.newsreader(
          color: AppColors.silver,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: 6,
        ),
        bodySmall: GoogleFonts.inter(
          color: AppColors.subtitleBlue,
          fontSize: 10.4,
          fontWeight: FontWeight.w500,
          letterSpacing: 4.16,
        ),
      ),
    );
  }
}
