import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          'About Rasseny',
          style: AppTextStyles.h2(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: padding.copyWith(top: context.scaleHeight(40)),
        child: Column(
          children: [
            // Logo Group
            PageEntranceAnimation(
              child: Column(
                children: [
                  Container(
                    width: context.scaleWidth(80),
                    height: context.scaleWidth(80),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccent,
                      borderRadius: AppRadius.card,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      LucideIcons.anchor,
                      size: context.scaleWidth(40),
                      color: AppColors.primaryForeground,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  Text('Rasseny Intelligence', style: AppTextStyles.h1(context)),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    'Version 2.0.4',
                    style: AppTextStyles.microText(context).copyWith(
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: context.scaleHeight(48)),
            
            // Description
            PageEntranceAnimation(
              delay: const Duration(milliseconds: 100),
              child: Text(
                'Rasseny is an AI-powered news intelligence platform designed to deliver precise, factual, and summarized insights from global media sources.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body(context).copyWith(
                  color: AppColors.silverSecondaryLabel,
                  height: 1.6,
                ),
              ),
            ),
            
            SliverToBoxAdapter(child: SizedBox(height: context.scaleHeight(48))),
            
            // Links Section
            _buildLinkTile(context, 'Terms of Service', LucideIcons.fileText),
            _buildLinkTile(context, 'Privacy Policy', LucideIcons.shieldCheck),
            _buildLinkTile(context, 'Community Guidelines', LucideIcons.users),
            _buildLinkTile(context, 'Send Feedback', LucideIcons.mail),
            
            SizedBox(height: context.scaleHeight(32)),
            
            // Socials
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(context, LucideIcons.globe),
                SizedBox(width: context.scaleWidth(24)),
                _buildSocialIcon(context, LucideIcons.link),
                SizedBox(width: context.scaleWidth(24)),
                _buildSocialIcon(context, LucideIcons.globe),
              ],
            ),
            
            SizedBox(height: AppSpacing.bottomScrollPadding(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkTile(BuildContext context, String title, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(12)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.button,
        border: Border.all(color: AppColors.silverBorder),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryAccent, size: context.scaleWidth(20)),
        title: Text(
          title,
          style: AppTextStyles.buttonLabel(context).copyWith(color: AppColors.foreground),
        ),
        trailing: Icon(LucideIcons.chevronRight, color: AppColors.muted, size: context.scaleWidth(16)),
        onTap: () {},
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon) {
    return PressScaleAnimation(
      onTap: () {},
      child: Icon(
        icon,
        color: AppColors.silverPlaceholder,
        size: context.scaleWidth(24),
      ),
    );
  }
}
