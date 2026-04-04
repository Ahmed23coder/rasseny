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
import '../../viewmodels/channels/channels_cubit.dart';

class ChannelsScreen extends StatelessWidget {
  const ChannelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChannelsCubit()..load(),
      child: const _ChannelsBody(),
    );
  }
}

class _ChannelsBody extends StatelessWidget {
  const _ChannelsBody();

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
          'My Channels',
          style: AppTextStyles.h2(context),
        ),
      ),
      body: BlocBuilder<ChannelsCubit, ChannelsState>(
        builder: (context, state) {
          if (state.status == ChannelsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            padding: padding.copyWith(
              top: context.scaleHeight(16),
              bottom: AppSpacing.bottomScrollPadding(context),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: context.scaleWidth(16),
              mainAxisSpacing: context.scaleHeight(16),
              childAspectRatio: 0.85,
            ),
            itemCount: state.channels.length,
            itemBuilder: (context, index) {
              final channel = state.channels[index];
              return PageEntranceAnimation(
                delay: Duration(milliseconds: index * 40),
                child: _ChannelCard(
                  name: channel['name'],
                  followers: channel['followers'],
                  letter: channel['letter'],
                  isFollowed: channel['isFollowed'],
                  onTap: () => context.read<ChannelsCubit>().toggleFollow(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ChannelCard extends StatelessWidget {
  final String name;
  final String followers;
  final String letter;
  final bool isFollowed;
  final VoidCallback onTap;

  const _ChannelCard({
    required this.name,
    required this.followers,
    required this.letter,
    required this.isFollowed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scaleWidth(16)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.silverBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo / Avatar
          Container(
            width: context.scaleWidth(48),
            height: context.scaleWidth(48),
            decoration: BoxDecoration(
              color: AppColors.silver10,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              letter,
              style: AppTextStyles.h2(context).copyWith(
                color: AppColors.primaryAccent,
                fontSize: context.scaleFontSize(20),
              ),
            ),
          ),
          SizedBox(height: context.scaleHeight(12)),
          
          // Name
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.h4CardHeadline(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: context.scaleHeight(4)),
          
          // Followers
          Text(
            '$followers followers',
            style: AppTextStyles.microText(context).copyWith(
              color: AppColors.silverSecondaryLabel,
            ),
          ),
          const Spacer(),
          
          // Follow Button
          PressScaleAnimation(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.scaleWidth(12),
                vertical: context.scaleHeight(8),
              ),
              decoration: BoxDecoration(
                color: isFollowed ? AppColors.silver10 : AppColors.primaryAccent,
                borderRadius: AppRadius.button,
              ),
              child: Text(
                isFollowed ? 'Following' : 'Follow',
                style: AppTextStyles.buttonLabel(context).copyWith(
                  color: isFollowed ? AppColors.foreground : AppColors.primaryForeground,
                  fontSize: context.scaleFontSize(12),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
