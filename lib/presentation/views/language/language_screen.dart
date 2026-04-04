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
import '../../viewmodels/language/language_cubit.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: const _LanguageBody(),
    );
  }
}

class _LanguageBody extends StatelessWidget {
  const _LanguageBody();

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
          'Language',
          style: AppTextStyles.h2(context),
        ),
      ),
      body: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return ListView.separated(
            padding: padding.copyWith(top: context.scaleHeight(24)),
            itemCount: LanguageCubit.supportedLanguages.length,
            separatorBuilder: (_, __) => SizedBox(height: context.scaleHeight(12)),
            itemBuilder: (context, index) {
              final lang = LanguageCubit.supportedLanguages[index];
              final isSelected = state.selectedCode == lang['code'];

              return PageEntranceAnimation(
                delay: Duration(milliseconds: index * 40),
                child: _LanguageItem(
                  name: lang['name']!,
                  native: lang['native']!,
                  isSelected: isSelected,
                  onTap: () => context.read<LanguageCubit>().selectLanguage(lang['code']!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _LanguageItem extends StatelessWidget {
  final String name;
  final String native;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageItem({
    required this.name,
    required this.native,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PressScaleAnimation(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleWidth(20),
          vertical: context.scaleHeight(16),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.silverGlass : AppColors.card,
          borderRadius: AppRadius.button,
          border: Border.all(
            color: isSelected ? AppColors.primaryAccent : AppColors.silverBorder,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.buttonLabel(context).copyWith(
                    color: isSelected ? AppColors.foreground : AppColors.silverSecondaryLabel,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                SizedBox(height: context.scaleHeight(2)),
                Text(
                  native,
                  style: AppTextStyles.microText(context).copyWith(
                    color: AppColors.silverPlaceholder,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                LucideIcons.check,
                color: AppColors.primaryAccent,
                size: context.scaleWidth(20),
              ),
          ],
        ),
      ),
    );
  }
}
