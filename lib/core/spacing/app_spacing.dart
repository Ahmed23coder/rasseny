import 'package:flutter/material.dart';

import '../utils/responsive_util.dart';

/// Rasseny Design System — Spacing Tokens
///
/// All spacing is context-aware and scales with [ResponsiveUtil].
class AppSpacing {
  AppSpacing._();

  /// Horizontal page padding (20 px equivalent)
  static double horizontalPadding(BuildContext context) =>
      context.scaleWidth(20);

  /// Vertical section spacing (24 px equivalent)
  static double sectionSpacing(BuildContext context) => context.scaleWidth(24);

  /// Gap between category pills
  static double pillGap(BuildContext context) => context.scaleWidth(8);

  /// Gap between list items (10–14 range)
  static double listGap(BuildContext context) => context.scaleWidth(12);

  /// Extra bottom padding so content isn't hidden behind the nav bar
  static double bottomScrollPadding(BuildContext context) =>
      context.scaleHeight(128);

  /// Convenience: symmetric horizontal page padding as [EdgeInsets].
  static EdgeInsets pagePadding(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: horizontalPadding(context));
}
