import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';

/// Uppercase category pill with active / inactive states.
class CategoryPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const CategoryPill({
    super.key,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PressScaleAnimation(
      onTap: onTap,
      scaleOnPress: 0.95,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleWidth(16),
          vertical: context.scaleHeight(8),
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryAccent : Colors.transparent,
          borderRadius: AppRadius.button,
          border: Border.all(
            color: isActive
                ? AppColors.primaryAccent
                : AppColors.silverInactivePill,
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: AppTextStyles.categoryPill(context).copyWith(
            color: isActive
                ? AppColors.primaryForeground
                : AppColors.silverPlaceholder,
          ),
        ),
      ),
    );
  }
}
