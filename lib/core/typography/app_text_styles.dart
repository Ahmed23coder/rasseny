import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../utils/responsive_util.dart';

/// Rasseny Design System — Typography
///
/// Headlines use **Newsreader** (serif); body / UI uses **Inter** (sans-serif).
/// Every style accepts [BuildContext] for responsive font scaling.
class AppTextStyles {
  AppTextStyles._();

  static const String _headline = 'Newsreader';
  static const String _body = 'Inter';

  // ── Headlines ────────────────────────────────────────────────

  /// App name — Newsreader 700, 20–24, line-height 1.2
  static TextStyle appName(BuildContext context) => TextStyle(
    fontFamily: _headline,
    fontWeight: FontWeight.w700,
    fontSize: context.scaleFontSize(22),
    height: 1.2,
    color: AppColors.foreground,
  );

  /// H1 Screen Title — Newsreader 700, 28, line-height 1.2
  static TextStyle h1(BuildContext context) => TextStyle(
    fontFamily: _headline,
    fontWeight: FontWeight.w700,
    fontSize: context.scaleFontSize(28),
    height: 1.2,
    color: AppColors.foreground,
  );

  /// H2 Section Title — Newsreader 700, 20–22, line-height 1.3
  static TextStyle h2(BuildContext context) => TextStyle(
    fontFamily: _headline,
    fontWeight: FontWeight.w700,
    fontSize: context.scaleFontSize(21),
    height: 1.3,
    color: AppColors.foreground,
  );

  /// H4 Card Headline — Newsreader 600, 14–15
  static TextStyle h4CardHeadline(BuildContext context) => TextStyle(
    fontFamily: _headline,
    fontWeight: FontWeight.w600,
    fontSize: context.scaleFontSize(14.5),
    color: AppColors.foreground,
  );

  // ── Body / UI ────────────────────────────────────────────────

  /// Body Text — Inter 400, 16, line-height 1.6
  static TextStyle body(BuildContext context) => TextStyle(
    fontFamily: _body,
    fontWeight: FontWeight.w400,
    fontSize: context.scaleFontSize(16),
    height: 1.6,
    color: AppColors.bodyText,
  );

  /// Button Label — Inter 500, 14–16
  static TextStyle buttonLabel(BuildContext context) => TextStyle(
    fontFamily: _body,
    fontWeight: FontWeight.w500,
    fontSize: context.scaleFontSize(15),
    color: AppColors.primaryForeground,
  );

  /// Input Text — Inter 400, 14
  static TextStyle inputText(BuildContext context) => TextStyle(
    fontFamily: _body,
    fontWeight: FontWeight.w400,
    fontSize: context.scaleFontSize(14),
    color: AppColors.foreground,
  );

  /// Category Pill — Inter 400, 11, uppercase, wide letter-spacing
  static TextStyle categoryPill(BuildContext context) => TextStyle(
    fontFamily: _body,
    fontWeight: FontWeight.w400,
    fontSize: context.scaleFontSize(11),
    letterSpacing: 1.2,
    color: AppColors.foreground,
  );

  /// Caption / Meta — Inter 400, 10–11
  static TextStyle caption(BuildContext context) => TextStyle(
    fontFamily: _body,
    fontWeight: FontWeight.w400,
    fontSize: context.scaleFontSize(10.5),
    color: AppColors.silverTimestamp,
  );

  /// Section Label — Inter 500, 10, uppercase, letter-spacing ≈ 0.2 em
  static TextStyle sectionLabel(BuildContext context) => TextStyle(
    fontFamily: _body,
    fontWeight: FontWeight.w500,
    fontSize: context.scaleFontSize(10),
    letterSpacing: 2.0,
    color: AppColors.silverSecondaryLabel,
  );

  /// Micro Text — Inter 400, 9–10
  static TextStyle microText(BuildContext context) => TextStyle(
    fontFamily: _body,
    fontWeight: FontWeight.w400,
    fontSize: context.scaleFontSize(9.5),
    color: AppColors.silverTimestamp,
  );

  /// Error Text — Inter 400, 12, decorative
  static TextStyle error(BuildContext context) => TextStyle(
    fontFamily: _body,
    fontWeight: FontWeight.w400,
    fontSize: context.scaleFontSize(12),
    color: AppColors.destructive,
  );
}
