import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/responsive_util.dart';

/// A grouped settings panel with rows separated by dividers.
///
/// ```dart
/// SettingsGroup(
///   children: [
///     SettingsRow(icon: Icons.language, label: 'Language', trailing: Text('EN')),
///     SettingsRow(icon: Icons.palette, label: 'Theme', onTap: () {}),
///   ],
/// )
/// ```
class SettingsGroup extends StatelessWidget {
  final List<SettingsRow> children;

  const SettingsGroup({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.settingsGroup,
        border: Border.all(color: AppColors.silverBorder),
      ),
      child: Column(
        children: List.generate(children.length, (i) {
          return Column(
            children: [
              children[i],
              if (i < children.length - 1)
                Divider(
                  height: 1,
                  color: AppColors.silverBorder,
                  indent: context.scaleWidth(56),
                ),
            ],
          );
        }),
      ),
    );
  }
}

/// A single row inside a [SettingsGroup].
class SettingsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsRow({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.settingsGroup,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleWidth(16),
          vertical: context.scaleHeight(14),
        ),
        child: Row(
          children: [
            Container(
              width: context.scaleWidth(32),
              height: context.scaleWidth(32),
              decoration: BoxDecoration(
                color: AppColors.silverFaint,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: AppColors.foreground),
            ),
            SizedBox(width: context.scaleWidth(12)),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.body(
                  context,
                ).copyWith(color: AppColors.foreground, height: 1.2),
              ),
            ),
            trailing ??
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: AppColors.silverTimestamp,
                ),
          ],
        ),
      ),
    );
  }
}
