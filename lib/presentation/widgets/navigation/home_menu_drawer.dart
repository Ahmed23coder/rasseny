import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/responsive_util.dart';
import '../../viewmodels/home/home_menu_cubit.dart';

class HomeMenuDrawer extends StatelessWidget {
  const HomeMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeMenuCubit(),
      child: const _DrawerBody(),
    );
  }
}

class _DrawerBody extends StatelessWidget {
  const _DrawerBody();

  @override
  Widget build(BuildContext context) {
    final width = context.scaleWidth(320);

    return Container(
      width: width,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.8),
        border: Border(
          right: BorderSide(color: AppColors.silverBorder),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.all(context.scaleWidth(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rasseny', style: AppTextStyles.appName(context)),
                    SizedBox(height: context.scaleHeight(4)),
                    Text(
                      'Intelligence',
                      style: AppTextStyles.caption(context).copyWith(
                        color: AppColors.silverSecondaryLabel,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white10),

              // ── Menu Items ────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: context.scaleHeight(12)),
                  itemCount: HomeMenuCubit.menuItems.length,
                  itemBuilder: (context, index) {
                    final item = HomeMenuCubit.menuItems[index];
                    return _MenuItem(
                      title: item['title'],
                      route: item['route'],
                      icon: _getIcon(item['icon']),
                    );
                  },
                ),
              ),

              // ── Footer ────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.all(context.scaleWidth(24)),
                child: Text(
                  'v1.0.0',
                  style: AppTextStyles.microText(context).copyWith(
                    color: AppColors.silverPlaceholder,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'history':
        return LucideIcons.history;
      case 'bookmark':
        return LucideIcons.bookmark;
      case 'tv':
        return LucideIcons.tv;
      case 'globe':
        return LucideIcons.globe;
      case 'bell':
        return LucideIcons.bell;
      case 'settings':
        return LucideIcons.settings;
      case 'credit-card':
        return LucideIcons.creditCard;
      case 'info':
        return LucideIcons.info;
      default:
        return LucideIcons.circle;
    }
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;

  const _MenuItem({
    required this.title,
    required this.route,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeMenuCubit>();
    final isActive = cubit.state.activeRoute == route;

    return InkWell(
      onTap: () {
        cubit.selectItem(route);
        Navigator.pop(context); // Close drawer
        context.go(route);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: context.scaleWidth(16),
          vertical: context.scaleHeight(4),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleWidth(16),
          vertical: context.scaleHeight(14),
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.silver10 : Colors.transparent,
          borderRadius: AppRadius.button,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: context.scaleWidth(20),
              color: isActive ? AppColors.primaryAccent : AppColors.silverPlaceholder,
            ),
            SizedBox(width: context.scaleWidth(16)),
            Text(
              title,
              style: AppTextStyles.buttonLabel(context).copyWith(
                color: isActive ? AppColors.foreground : AppColors.silverSecondaryLabel,
                fontSize: context.scaleFontSize(15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
