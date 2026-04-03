import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../domain/repositories/news_repository.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';
import '../../viewmodels/home/home_cubit.dart';
import '../../widgets/cards/article_card.dart';
import '../../widgets/inputs/app_search_bar.dart';
import '../../widgets/pills/category_pill.dart';

/// Fully implemented Home screen — demonstrates the design system in action.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(context.read<NewsRepository>())..load(),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.pagePadding(context);

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          // ── Header ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: PageEntranceAnimation(
              child: Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.scaleHeight(16)),
                    Row(
                      children: [
                        Text('Rasseny', style: AppTextStyles.appName(context)),
                        const Spacer(),
                        Icon(
                          LucideIcons.bell,
                          color: AppColors.silverSecondaryLabel,
                          size: 24,
                        ),
                      ],
                    ),
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
            ),
          ),

          // ── Search ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: PageEntranceAnimation(
              delay: const Duration(milliseconds: 100),
              child: Padding(
                padding: padding.copyWith(
                  top: context.scaleHeight(20),
                  bottom: context.scaleHeight(16),
                ),
                child: const AppSearchBar(hintText: 'Search articles...'),
              ),
            ),
          ),

          // ── Category pills ────────────────────────────────────
          SliverToBoxAdapter(
            child: PageEntranceAnimation(
              delay: const Duration(milliseconds: 200),
              child: SizedBox(
                height: context.scaleHeight(40),
                child: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (p, c) =>
                      p.categories != c.categories ||
                      p.selectedCategory != c.selectedCategory ||
                      p.status != c.status,
                  builder: (context, state) {
                    if (state.status == HomeStatus.loading && state.categories.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: padding,
                      itemCount: state.categories.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(width: AppSpacing.pillGap(context)),
                      itemBuilder: (_, i) {
                        final cat = state.categories[i];
                        return CategoryPill(
                          label: cat,
                          isActive: cat == state.selectedCategory,
                          onTap: () =>
                              context.read<HomeCubit>().selectCategory(cat),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),

          // ── Section title ─────────────────────────────────────
          SliverToBoxAdapter(
            child: PageEntranceAnimation(
              delay: const Duration(milliseconds: 300),
              child: Padding(
                padding: padding.copyWith(
                  top: context.scaleHeight(24),
                  bottom: context.scaleHeight(12),
                ),
                child: Text(
                  'TRENDING',
                  style: AppTextStyles.sectionLabel(context),
                ),
              ),
            ),
          ),

          // ── Article list ──────────────────────────────────────
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (p, c) => p.articles != c.articles || p.status != c.status,
            builder: (context, state) {
              if (state.status == HomeStatus.loading && state.articles.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state.status == HomeStatus.error) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      state.errorMessage ?? 'Failed to load articles',
                      style: AppTextStyles.error(context),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: padding.copyWith(
                  bottom: AppSpacing.bottomScrollPadding(context),
                ),
                sliver: SliverList.separated(
                  itemCount: state.articles.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: AppSpacing.listGap(context)),
                  itemBuilder: (_, i) {
                    final article = state.articles[i];
                    return PageEntranceAnimation(
                      delay: Duration(milliseconds: 350 + (i * 60)),
                      child: ArticleCard(
                        title: article.title,
                        category: article.category,
                        source: article.source,
                        timeAgo: article.timeAgo,
                        thumbnailUrl: article.thumbnailUrl,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
