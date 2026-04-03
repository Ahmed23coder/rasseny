import 'package:flutter/material.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/utils/responsive_util.dart';
import '../../../core/utils/app_animations.dart';

/// Interactive chip for the interests selection screen.
class InterestChip extends StatelessWidget {
  final String label;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const InterestChip({
    super.key,
    required this.label,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PressScaleAnimation(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleWidth(16),
          vertical: context.scaleHeight(12),
        ),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.primaryAccent.withValues(alpha: 0.15) 
              : AppColors.silver04,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isSelected 
                ? AppColors.primaryAccent.withValues(alpha: 0.5) 
                : AppColors.silverBorder,
            width: 1.185,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: context.scaleFontSize(16)),
            ),
            SizedBox(width: context.scaleWidth(8)),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: context.scaleFontSize(14),
                color: isSelected ? Colors.white : AppColors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
