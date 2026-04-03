import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/theme/glass_surface.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/responsive_util.dart';

/// Glass-backed search bar with clear icon.
class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const AppSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GlassSurface.decoration(
        intensity: GlassIntensity.subtle,
        borderRadius: AppRadius.button,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTextStyles.inputText(context),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: context.scaleFontSize(14),
            color: AppColors.silverPlaceholder,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.silverPlaceholder,
            size: 20,
          ),
          suffixIcon: controller != null
              ? ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller!,
                  builder: (_, value, __) {
                    if (value.text.isEmpty) return const SizedBox.shrink();
                    return IconButton(
                      icon: Icon(
                        Icons.close,
                        color: AppColors.silverPlaceholder,
                        size: 18,
                      ),
                      onPressed: () {
                        controller!.clear();
                        onClear?.call();
                      },
                    );
                  },
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(16),
            vertical: context.scaleHeight(14),
          ),
        ),
      ),
    );
  }
}
