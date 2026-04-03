import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';

/// Outline button — transparent with silver 20 % border.
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const SecondaryButton({
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
          color: Colors.transparent,
          borderRadius: AppRadius.button,
          border: Border.all(color: AppColors.silverBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: AppColors.silverSecondaryLabel),
              SizedBox(width: context.scaleWidth(8)),
            ],
            Text(
              label,
              style: AppTextStyles.buttonLabel(context).copyWith(
                color: AppColors.primaryAccent.withValues(alpha: 0.70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
