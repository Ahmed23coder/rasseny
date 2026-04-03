import 'dart:ui';

/// Rasseny Design System — Color Tokens
///
/// Every colour in the palette is defined here. UI code should NEVER
/// hard-code hex values; always reference [AppColors].
class AppColors {
  AppColors._();

  // ── Core Palette ─────────────────────────────────────────────
  static const Color background = Color(0xFF102A43); // Midnight Navy
  static const Color card = Color(0xFF243B53);
  static const Color secondarySurface = Color(0xFF334E68);
  static const Color muted = Color(0xFF486581);

  static const Color primaryAccent = Color(0xFFC0C0C0); // Silver
  static const Color primaryForeground = Color(0xFF102A43);
  static const Color foreground = Color(0xFFFFFFFF);
  static const Color bodyText = Color(0xFFB0C4DE);
  static const Color mutedForeground = Color(0xFFBCCCDC);

  static const Color accentBlue = Color(0xFF2979FF);
  static const Color destructive = Color(0xFFD4183D);
  static const Color ring = Color(0xFFC0C0C0);

  // ── Computed Border ──────────────────────────────────────────
  static Color get borderColor => primaryAccent.withValues(alpha: 0.20);

  // ── Silver Opacity Helpers ───────────────────────────────────
  /// 80 % — High emphasis
  static Color get silver80 => primaryAccent.withValues(alpha: 0.80);

  /// 70 % — Medium emphasis
  static Color get silver70 => primaryAccent.withValues(alpha: 0.70);

  /// 60 % — secondary labels
  static Color get silverSecondaryLabel =>
      primaryAccent.withValues(alpha: 0.60);

  /// 50 % — placeholders
  static Color get silverPlaceholder => primaryAccent.withValues(alpha: 0.50);

  /// 40 % — timestamps
  static Color get silverTimestamp => primaryAccent.withValues(alpha: 0.40);

  /// 30 % — disabled elements
  static Color get silverDisabled => primaryAccent.withValues(alpha: 0.30);

  /// 20 % — borders / dividers
  static Color get silverBorder => primaryAccent.withValues(alpha: 0.20);

  /// 15 % — inactive pills
  static Color get silverInactivePill => primaryAccent.withValues(alpha: 0.15);

  /// 10 % — faint backgrounds
  static Color get silver10 => primaryAccent.withValues(alpha: 0.10);

  /// 10 % — legacy alias
  static Color get silverFaint => silver10;

  /// 8 % — container backgrounds
  static Color get silver08 => primaryAccent.withValues(alpha: 0.08);

  /// 6 % — subtle backgrounds
  static Color get silver06 => primaryAccent.withValues(alpha: 0.06);

  /// 4 % — barely visible
  static Color get silver04 => primaryAccent.withValues(alpha: 0.04);

  /// 5 % — legacy glass surface (keep for compatibility)
  static Color get silverGlass => primaryAccent.withValues(alpha: 0.05);
}
