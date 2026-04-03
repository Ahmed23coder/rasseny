import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/theme/glass_surface.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';

/// 36×36 glass-backed icon button with press-scale animation.
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double? size;
  final Color? iconColor;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final dim = size ?? context.scaleWidth(36);

    return PressScaleAnimation(
      onTap: onPressed,
      scaleOnPress: 0.90,
      child: Container(
        width: dim,
        height: dim,
        alignment: Alignment.center,
        decoration: GlassSurface.decoration(
          intensity: GlassIntensity.subtle,
          borderRadius: AppRadius.button,
        ),
        child: Icon(
          icon,
          size: dim * 0.5,
          color: iconColor ?? AppColors.foreground,
        ),
      ),
    );
  }
}
