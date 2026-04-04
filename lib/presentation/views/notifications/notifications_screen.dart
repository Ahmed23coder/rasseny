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
import '../../viewmodels/notifications/notifications_cubit.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit()..load(),
      child: const _NotificationsBody(),
    );
  }
}

class _NotificationsBody extends StatelessWidget {
  const _NotificationsBody();

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
          'Notifications',
          style: AppTextStyles.h2(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              LucideIcons.trash2,
              size: context.scaleWidth(20),
              color: AppColors.muted,
            ),
            onPressed: () => context.read<NotificationsCubit>().clearAll(),
          ),
          SizedBox(width: context.scaleWidth(8)),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.status == NotificationsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.notifications.isEmpty) {
            return _buildEmptyState(context);
          }

          return ListView.separated(
            padding: padding.copyWith(
              top: context.scaleHeight(16),
              bottom: AppSpacing.bottomScrollPadding(context),
            ),
            itemCount: state.notifications.length,
            separatorBuilder: (_, __) => SizedBox(height: context.scaleHeight(12)),
            itemBuilder: (context, index) {
              final n = state.notifications[index];
              return PageEntranceAnimation(
                delay: Duration(milliseconds: index * 50),
                child: _NotificationTile(
                  id: n['id'],
                  title: n['title'],
                  body: n['body'],
                  time: n['time'],
                  type: n['type'],
                  isRead: n['isRead'],
                  onTap: () => context.read<NotificationsCubit>().markAsRead(n['id']),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.bellOff,
            size: context.scaleWidth(64),
            color: AppColors.muted,
          ),
          SizedBox(height: context.scaleHeight(24)),
          Text(
            'No Notifications',
            style: AppTextStyles.h2(context).copyWith(color: AppColors.muted),
          ),
          SizedBox(height: context.scaleHeight(8)),
          Text(
            "You're all caught up!",
            style: AppTextStyles.body(context).copyWith(color: AppColors.silverPlaceholder),
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String id;
  final String title;
  final String body;
  final String time;
  final String type;
  final bool isRead;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color iconColor;

    switch (type) {
      case 'breaking':
        icon = LucideIcons.zap;
        iconColor = AppColors.destructive;
        break;
      case 'success':
        icon = LucideIcons.circleCheck;
        iconColor = AppColors.success;
        break;
      default:
        icon = LucideIcons.info;
        iconColor = AppColors.primaryAccent;
    }

    return PressScaleAnimation(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.scaleWidth(16)),
        decoration: BoxDecoration(
          color: isRead ? AppColors.card : AppColors.primaryAccent.withValues(alpha: 0.1),
          borderRadius: AppRadius.card,
          border: Border.all(
            color: isRead ? AppColors.silverBorder : AppColors.primaryAccent.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Indicator
            Container(
              padding: EdgeInsets.all(context.scaleWidth(10)),
              decoration: BoxDecoration(
                color: isRead ? AppColors.silver10 : AppColors.primaryAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: context.scaleWidth(20)),
            ),
            SizedBox(width: context.scaleWidth(16)),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.buttonLabel(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.foreground,
                        ),
                      ),
                      Text(
                        time,
                        style: AppTextStyles.microText(context).copyWith(
                          color: AppColors.silverPlaceholder,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    body,
                    style: AppTextStyles.body(context).copyWith(
                      color: AppColors.silverSecondaryLabel,
                      fontSize: context.scaleFontSize(13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
