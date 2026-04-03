import 'dart:ui';
import 'package:flutter/material.dart';

/// Glass intensity presets matching the design spec.
enum GlassIntensity { subtle, standard, elevated }

/// Frosted-glass surface widget with backdrop blur.
class GlassSurface extends StatelessWidget {
  final Widget child;
  final GlassIntensity intensity;
  final double blurSigma;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const GlassSurface({
    super.key,
    required this.child,
    this.intensity = GlassIntensity.standard,
    this.blurSigma = 12.0,
    this.borderRadius,
    this.padding,
  });

  factory GlassSurface.subtle({
    Key? key,
    required Widget child,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) => GlassSurface(
    key: key,
    intensity: GlassIntensity.subtle,
    blurSigma: 8.0,
    borderRadius: borderRadius,
    padding: padding,
    child: child,
  );

  factory GlassSurface.glassMorphism({
    Key? key,
    required Widget child,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) => GlassSurface(
    key: key,
    intensity: GlassIntensity.standard,
    blurSigma: 12.0,
    borderRadius: borderRadius,
    padding: padding,
    child: child,
  );

  factory GlassSurface.elevated({
    Key? key,
    required Widget child,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) => GlassSurface(
    key: key,
    intensity: GlassIntensity.elevated,
    blurSigma: 20.0,
    borderRadius: borderRadius,
    padding: padding,
    child: child,
  );

  Color get _backgroundColor => switch (intensity) {
    GlassIntensity.subtle => Colors.white.withValues(alpha: 0.05),
    GlassIntensity.standard => Colors.white.withValues(alpha: 0.08),
    GlassIntensity.elevated => Colors.white.withValues(alpha: 0.10),
  };

  Color get _borderColor => switch (intensity) {
    GlassIntensity.subtle => Colors.white.withValues(alpha: 0.08),
    GlassIntensity.standard => Colors.white.withValues(alpha: 0.10),
    GlassIntensity.elevated => Colors.white.withValues(alpha: 0.20),
  };

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(24);
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: radius,
            border: Border.all(color: _borderColor),
          ),
          child: child,
        ),
      ),
    );
  }

  /// Non-blur [BoxDecoration] for opaque dark surfaces.
  static BoxDecoration decoration({
    GlassIntensity intensity = GlassIntensity.standard,
    BorderRadius? borderRadius,
  }) {
    final (bg, border) = switch (intensity) {
      GlassIntensity.subtle => (
        Colors.white.withValues(alpha: 0.05),
        Colors.white.withValues(alpha: 0.08),
      ),
      GlassIntensity.standard => (
        Colors.white.withValues(alpha: 0.08),
        Colors.white.withValues(alpha: 0.10),
      ),
      GlassIntensity.elevated => (
        Colors.white.withValues(alpha: 0.10),
        Colors.white.withValues(alpha: 0.20),
      ),
    };
    return BoxDecoration(
      color: bg,
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      border: Border.all(color: border),
    );
  }
}
