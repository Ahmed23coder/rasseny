import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/responsive_util.dart';
import '../../../core/theme/glass_surface.dart';

/// Header for Login/SignUp with a logo in a glass circle, title, and subtitle.
class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final double circleSize;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.circleSize = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: context.scaleWidth(circleSize),
          height: context.scaleWidth(circleSize),
          decoration: GlassSurface.decoration(
            intensity: GlassIntensity.subtle,
            borderRadius: BorderRadius.circular(50),
            borderWidth: 1.185,
          ),
          alignment: Alignment.center,
          child: Icon(
            LucideIcons.anchor,
            color: AppColors.foreground,
            size: context.scaleWidth(circleSize * 0.5),
          ),
        ),
        SizedBox(height: context.scaleHeight(24)),
        Text(
          title,
          style: AppTextStyles.h1(context).copyWith(
            fontSize: context.scaleFontSize(24),
            height: 1.33, // 32/24 leading
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.scaleHeight(8)),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: context.scaleFontSize(12),
            height: 1.33, // 16/12 leading
            color: AppColors.silverSecondaryLabel,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
