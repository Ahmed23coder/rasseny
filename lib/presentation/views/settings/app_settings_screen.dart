import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';
import '../../viewmodels/settings/app_settings_cubit.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSettingsCubit(),
      child: const _AppSettingsBody(),
    );
  }
}

class _AppSettingsBody extends StatelessWidget {
  const _AppSettingsBody();

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.pagePadding(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'App Settings',
          style: AppTextStyles.h2(context),
        ),
      ),
      body: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, state) {
          return ListView(
            padding: padding.copyWith(top: context.scaleHeight(16)),
            children: [
              _buildSectionHeader(context, 'GENERAL'),
              _buildSettingTile(
                context,
                title: 'Dark Mode',
                icon: LucideIcons.moon,
                trailing: Switch.adaptive(
                  value: state.isDarkMode,
                  activeColor: AppColors.primaryAccent,
                  onChanged: (v) => context.read<AppSettingsCubit>().toggleDarkMode(v),
                ),
              ),
              _buildSettingTile(
                context,
                title: 'Push Notifications',
                icon: LucideIcons.bell,
                trailing: Switch.adaptive(
                  value: state.pushNotifications,
                  activeColor: AppColors.primaryAccent,
                  onChanged: (v) => context.read<AppSettingsCubit>().togglePushNotifications(v),
                ),
              ),
              
              SizedBox(height: context.scaleHeight(32)),
              _buildSectionHeader(context, 'AI ENGINE'),
              _buildSettingTile(
                context,
                title: 'Summary Length',
                icon: LucideIcons.sparkles,
                subtitle: 'Customize length of generated summaries',
              ),
              Padding(
                padding: EdgeInsets.only(top: context.scaleHeight(12)),
                child: _buildSummarySegmentedControl(context, state.summaryLength),
              ),

              SizedBox(height: context.scaleHeight(32)),
              _buildSectionHeader(context, 'SECURITY'),
              _buildSettingTile(
                context,
                title: 'Use Biometrics',
                icon: LucideIcons.lock,
                subtitle: 'Enable Face ID / Fingerprint lock',
                trailing: Switch.adaptive(
                  value: state.useBiometrics,
                  activeTrackColor: AppColors.primaryAccent,
                  onChanged: (v) => context.read<AppSettingsCubit>().toggleBiometrics(v),
                ),
              ),
              
              SizedBox(height: AppSpacing.bottomScrollPadding(context)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.scaleWidth(8),
        bottom: context.scaleHeight(12),
      ),
      child: Text(
        title,
        style: AppTextStyles.sectionLabel(context),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    String? subtitle,
    Widget? trailing,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(12)),
      padding: EdgeInsets.all(context.scaleWidth(16)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.silverBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.scaleWidth(10)),
            decoration: BoxDecoration(
              color: AppColors.silver10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryAccent, size: context.scaleWidth(20)),
          ),
          SizedBox(width: context.scaleWidth(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.buttonLabel(context).copyWith(
                    color: AppColors.foreground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    subtitle,
                    style: AppTextStyles.microText(context).copyWith(
                      color: AppColors.silverSecondaryLabel,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildSummarySegmentedControl(BuildContext context, int currentValue) {
    final labels = ['Short', 'Medium', 'Long'];
    return Container(
      height: context.scaleHeight(44),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.button,
        border: Border.all(color: AppColors.silverBorder),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final isSelected = index == currentValue;
          return Expanded(
            child: PressScaleAnimation(
              onTap: () => context.read<AppSettingsCubit>().setSummaryLength(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryAccent : Colors.transparent,
                  borderRadius: AppRadius.button,
                ),
                alignment: Alignment.center,
                child: Text(
                  labels[index],
                  style: AppTextStyles.microText(context).copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColors.primaryForeground : AppColors.silverSecondaryLabel,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
