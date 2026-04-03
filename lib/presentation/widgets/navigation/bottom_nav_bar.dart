import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/utils/responsive_util.dart';

/// Bottom navigation bar with 6 tabs, silver active indicator, and frosted glass.
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _tabs = <_NavTab>[
    _NavTab(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
    _NavTab(
      icon: Icons.search_outlined,
      activeIcon: Icons.search,
      label: 'Search',
    ),
    _NavTab(
      icon: Icons.auto_awesome_outlined,
      activeIcon: Icons.auto_awesome,
      label: 'Summarize',
    ),
    _NavTab(
      icon: Icons.fact_check_outlined,
      activeIcon: Icons.fact_check,
      label: 'Fact Check',
    ),
    _NavTab(
      icon: Icons.folder_outlined,
      activeIcon: Icons.folder,
      label: 'Vault',
    ),
    _NavTab(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final maxWidth = context.scaleWidth(393);
    final barHeight = context.scaleHeight(64);

    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            height: barHeight + MediaQuery.paddingOf(context).bottom,
            padding: EdgeInsets.only(
              bottom: MediaQuery.paddingOf(context).bottom,
            ),
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.95),
              border: Border(top: BorderSide(color: AppColors.silverBorder)),
            ),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final active = i == currentIndex;
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTap(i),
                    child: _TabItem(
                      tab: _tabs[i],
                      active: active,
                      barHeight: barHeight,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Private helpers ──────────────────────────────────────────────

class _NavTab {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavTab({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class _TabItem extends StatelessWidget {
  final _NavTab tab;
  final bool active;
  final double barHeight;

  const _TabItem({
    required this.tab,
    required this.active,
    required this.barHeight,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = active
        ? AppColors.primaryAccent
        : AppColors.primaryAccent.withValues(alpha: 0.30);

    return SizedBox(
      height: barHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Silver active indicator bar
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 3,
            width: active ? 24 : 0,
            decoration: BoxDecoration(
              color: active ? AppColors.primaryAccent : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Spacer(),
          Icon(active ? tab.activeIcon : tab.icon, color: iconColor, size: 24),
          const SizedBox(height: 4),
          Text(
            tab.label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              color: iconColor,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
