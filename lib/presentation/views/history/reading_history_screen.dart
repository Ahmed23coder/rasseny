import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';
import '../../viewmodels/history/reading_history_cubit.dart';
import '../../widgets/cards/article_card.dart';

class ReadingHistoryScreen extends StatelessWidget {
  const ReadingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReadingHistoryCubit()..load(),
      child: const _ReadingHistoryBody(),
    );
  }
}

class _ReadingHistoryBody extends StatelessWidget {
  const _ReadingHistoryBody();

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
          'History',
          style: AppTextStyles.h2(context),
        ),
        actions: [
          TextButton(
            onPressed: () => context.read<ReadingHistoryCubit>().clearHistory(),
            child: Text(
              'Clear',
              style: AppTextStyles.buttonLabel(context).copyWith(
                color: AppColors.primaryAccent,
              ),
            ),
          ),
          SizedBox(width: context.scaleWidth(8)),
        ],
      ),
      body: BlocBuilder<ReadingHistoryCubit, ReadingHistoryState>(
        builder: (context, state) {
          if (state.status == HistoryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.groupedArticles.isEmpty) {
            return _buildEmptyState(context);
          }

          return CustomScrollView(
            slivers: [
              for (final group in state.groupedArticles.entries) ...[
                // Section Header
                SliverToBoxAdapter(
                  child: PageEntranceAnimation(
                    child: Padding(
                      padding: padding.copyWith(
                        top: context.scaleHeight(24),
                        bottom: context.scaleHeight(12),
                      ),
                      child: Text(
                        group.key.toUpperCase(),
                        style: AppTextStyles.sectionLabel(context),
                      ),
                    ),
                  ),
                ),
                
                // Article List for this group
                SliverPadding(
                  padding: padding,
                  sliver: SliverList.separated(
                    itemCount: group.value.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: AppSpacing.listGap(context)),
                    itemBuilder: (context, index) {
                      final article = group.value[index];
                      return PageEntranceAnimation(
                        delay: Duration(milliseconds: index * 50),
                        child: ArticleCard(
                          title: article.title,
                          category: article.category,
                          source: article.source,
                          timeAgo: article.timeAgo,
                          thumbnailUrl: article.thumbnailUrl,
                          onTap: () => context.push('/article/${article.id}'),
                        ),
                      );
                    },
                  ),
                ),
              ],
              SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.bottomScrollPadding(context)),
              ),
            ],
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
            LucideIcons.history,
            size: context.scaleWidth(64),
            color: AppColors.muted,
          ),
          SizedBox(height: context.scaleHeight(24)),
          Text(
            'No History Yet',
            style: AppTextStyles.h2(context).copyWith(color: AppColors.muted),
          ),
          SizedBox(height: context.scaleHeight(8)),
          Text(
            'Your reading journey starts here.',
            style: AppTextStyles.body(context).copyWith(color: AppColors.silverPlaceholder),
          ),
        ],
      ),
    );
  }
}
