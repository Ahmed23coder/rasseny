import 'package:flutter/material.dart';

/// Rasseny Design System — Radius Tokens
///
/// Stadium-pill design language. Every interactive surface uses pill
/// radii; cards and modals use softer rounded rectangles.
class AppRadius {
  AppRadius._();

  // ── Raw values ───────────────────────────────────────────────
  /// Global border width (frosted glass standard)
  static const double buttonValue = 1.185;

  /// Pill-style radius (Buttons / Inputs / Pills)
  static const double pillValue = 50.0;
  
  // ── Card values ──────────────────────────────────────────────
  /// Cards / Articles
  static const double cardValue = 24.0;


  /// Settings groups
  static const double settingsGroupValue = 28.0;

  /// Modals / Bottom sheets
  static const double modalValue = 32.0;

  /// Image thumbnails
  static const double imageThumbnailValue = 16.0;

  /// Nav pill bar
  static const double navPillValue = 999.0;

  /// Fully circular (avatars, toggles)
  static const double circularValue = 9999.0;

  // ── BorderRadius shortcuts ───────────────────────────────────
  static final BorderRadius button = BorderRadius.circular(pillValue);
  static final BorderRadius card = BorderRadius.circular(cardValue);
  static final BorderRadius settingsGroup = BorderRadius.circular(
    settingsGroupValue,
  );
  static final BorderRadius modal = BorderRadius.circular(modalValue);
  static final BorderRadius imageThumbnail = BorderRadius.circular(
    imageThumbnailValue,
  );
  static final BorderRadius navPill = BorderRadius.circular(navPillValue);
  static final BorderRadius circular = BorderRadius.circular(circularValue);
}
