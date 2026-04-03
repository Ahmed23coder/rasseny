import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';

/// Silver-filled call-to-action button with scale press animation.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = isDisabled || isLoading;
    final height = context.scaleHeight(56);

    final child = Container(
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: disabled ? AppColors.silverDisabled : AppColors.primaryAccent,
        borderRadius: AppRadius.button,
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primaryForeground,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18, color: AppColors.primaryForeground),
                  SizedBox(width: context.scaleWidth(8)),
                ],
                Text(label, style: AppTextStyles.buttonLabel(context)),
              ],
            ),
    );

    if (disabled) return child;

    return PressScaleAnimation(
      onTap: onPressed,
      scaleOnPress: 0.95,
      child: child,
    );
  }
}
