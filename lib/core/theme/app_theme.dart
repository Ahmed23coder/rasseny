import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../utils/size_config.dart';

/// Application-wide theme data following the Midnight Navy & Silver palette.
abstract final class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.navyButton, // #102A43 (navyButton)
      colorScheme: const ColorScheme.dark(
        primary: AppColors.silverGold, // #C0C0C0
        secondary: AppColors.inputBorderBlue, // #486581
        surface: AppColors.midnightNavy,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.newsreader(
          color: AppColors.silverGold, // bold #C0C0C0
          fontSize: 24 * SizeConfig.textMultiplier,
          fontWeight: FontWeight.w700,
          letterSpacing: 6,
        ),
        bodySmall: GoogleFonts.inter(
          color: AppColors.iceWhite, // #F0F4F8
          fontSize: 10.4 * SizeConfig.textMultiplier,
          fontWeight: FontWeight.w500,
          letterSpacing: 4.16,
        ),
      ),
      // Buttons scaled border radius
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28 * SizeConfig.imageSizeMultiplier),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28 * SizeConfig.imageSizeMultiplier),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28 * SizeConfig.imageSizeMultiplier),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28 * SizeConfig.imageSizeMultiplier),
          ),
        ),
      ),
      // Search Bar: Midnight Navy fill, Slate Blue border
      searchBarTheme: SearchBarThemeData(
        backgroundColor: const WidgetStatePropertyAll(AppColors.midnightNavy),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.inputBorderBlue),
            borderRadius: BorderRadius.circular(28 * SizeConfig.imageSizeMultiplier),
          ),
        ),
      ),
      // Navigation Bar: Obsidian floating style, active #C0C0C0
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.midnightNavy,
        indicatorColor: AppColors.navyButton,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.silverGold);
          }
          return const IconThemeData(color: AppColors.subtitleBlue);
        }),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.midnightNavy,
        selectedItemColor: AppColors.silverGold,
        unselectedItemColor: AppColors.subtitleBlue,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeScalePageTransitionsBuilder(),
          TargetPlatform.iOS: FadeScalePageTransitionsBuilder(),
          TargetPlatform.macOS: FadeScalePageTransitionsBuilder(),
        },
      ),
    );
  }
}

class FadeScalePageTransitionsBuilder extends PageTransitionsBuilder {
  const FadeScalePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.95, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          ),
        ),
        child: child,
      ),
    );
  }
}
