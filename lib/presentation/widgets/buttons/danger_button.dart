import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';

/// Red-tinted destructive action button.
class DangerButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const DangerButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final height = context.scaleHeight(56);

    return PressScaleAnimation(
      onTap: onPressed,
      scaleOnPress: 0.95,
      child: Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.destructive.withValues(alpha: 0.10),
          borderRadius: AppRadius.button,
          border: Border.all(
            color: AppColors.destructive.withValues(alpha: 0.20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: AppColors.destructive),
              SizedBox(width: context.scaleWidth(8)),
            ],
            Text(
              label,
              style: AppTextStyles.buttonLabel(
                context,
              ).copyWith(color: AppColors.destructive),
            ),
          ],
        ),
      ),
    );
  }
}
