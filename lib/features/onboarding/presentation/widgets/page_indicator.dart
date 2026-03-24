import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Dot-style page indicator for onboarding screens.
///
/// Active dot is 12×12 silver, inactive dots are 8×8 ghost-bordered squares.
class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    const double totalWidth = 100.0;
    // Calculate progress (e.g., 1/3, 2/3, 3/3)
    final double progress = (currentPage + 1) / pageCount;

    return Container(
      width: totalWidth,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.ghostBorder.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(2),
      ),
      alignment: Alignment.centerLeft,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        width: totalWidth * progress,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.silver,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: AppColors.silver.withValues(alpha: 0.5),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
