import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/utils/responsive_util.dart';

/// Custom toggle switch — ON: Silver, OFF: white 12 %, knob: Midnight Navy.
class AppToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const AppToggleSwitch({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final width = context.scaleWidth(44);
    final height = context.scaleWidth(24);
    final knobSize = height - 4; // 2 px padding each side

    return GestureDetector(
      onTap: () => onChanged?.call(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height),
          color: value
              ? AppColors.primaryAccent
              : Colors.white.withValues(alpha: 0.12),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: knobSize,
            height: knobSize,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryForeground,
            ),
          ),
        ),
      ),
    );
  }
}
