import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/theme/glass_surface.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';

/// A 40px glass circle button for back navigation in auth flows.
class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.scaleWidth(40);
    
    return PressScaleAnimation(
      onTap: () => context.pop(),
      child: Container(
        width: size,
        height: size,
        decoration: GlassSurface.decoration(
          intensity: GlassIntensity.subtle,
          borderRadius: AppRadius.button,
        ),
        alignment: Alignment.center,
        child: Icon(
          LucideIcons.chevronLeft,
          color: AppColors.foreground,
          size: context.scaleWidth(20),
        ),
      ),
    );
  }
}
