import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/app_colors.dart';
import '../radius/app_radius.dart';

/// Builds the single [ThemeData] used throughout the app.
///
/// Wires [AppColors] into the Material 3 colour scheme and configures
/// component themes so that raw Material widgets already look correct
/// without per-widget overrides.
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,

      // ── Colour scheme ──────────────────────────────────────────
      colorScheme: const ColorScheme.dark(
        surface: AppColors.background,
        primary: AppColors.primaryAccent,
        onPrimary: AppColors.primaryForeground,
        secondary: AppColors.accentBlue,
        onSecondary: AppColors.foreground,
        error: AppColors.destructive,
        onError: AppColors.foreground,
        onSurface: AppColors.foreground,
      ),

      // ── Default font ──────────────────────────────────────────
      fontFamily: 'Inter',

      // ── AppBar ─────────────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: AppColors.foreground),
        titleTextStyle: TextStyle(
          fontFamily: 'Newsreader',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: AppColors.foreground,
        ),
      ),

      // ── Bottom sheet ───────────────────────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.modalValue),
            topRight: Radius.circular(AppRadius.modalValue),
          ),
        ),
      ),

      // ── Dialog ─────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.modal),
      ),

      // ── Divider ────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: AppColors.silverBorder,
        thickness: 1,
      ),

      // ── Text fields (global baseline — widgets add their own
      //    decoration when they need more control) ────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.button,
          borderSide: BorderSide(color: AppColors.silverBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.button,
          borderSide: BorderSide(color: AppColors.silverBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.button,
          borderSide: BorderSide(color: AppColors.silverBorder),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.button,
          borderSide: const BorderSide(color: AppColors.destructive),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: AppColors.silverPlaceholder,
        ),
      ),

      // ── Cursor / selection ─────────────────────────────────────
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryAccent,
        selectionColor: Color(0x40C0C0C0),
        selectionHandleColor: AppColors.primaryAccent,
      ),
    );
  }
}
