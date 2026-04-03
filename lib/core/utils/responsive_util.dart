import 'package:flutter/material.dart';

/// Design reference dimensions — iPhone 15 Pro
const double kDesignWidth = 393.0;
const double kDesignHeight = 852.0;

/// Responsive helpers accessed via `context.scaleWidth(20)`, etc.
///
/// All sizing in the app flows through these helpers so that every
/// dimension scales proportionally on different screen sizes.
extension ResponsiveUtil on BuildContext {
  Size get _size => MediaQuery.sizeOf(this);

  double get screenWidth => _size.width;
  double get screenHeight => _size.height;

  /// 1 % of screen width / height
  double get blockH => screenWidth / 100;
  double get blockV => screenHeight / 100;

  /// Scale a design-pixel value proportionally to screen width.
  double scaleWidth(double px) => px * (screenWidth / kDesignWidth);

  /// Scale a design-pixel value proportionally to screen height.
  double scaleHeight(double px) => px * (screenHeight / kDesignHeight);

  /// Scale font size relative to design width, clamped for readability
  /// so text never shrinks below 80 % or grows above 130 % of nominal.
  double scaleFontSize(double px) {
    final scaled = px * (screenWidth / kDesignWidth);
    return scaled.clamp(px * 0.8, px * 1.3);
  }
}
