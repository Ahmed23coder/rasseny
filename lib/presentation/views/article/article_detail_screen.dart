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
import '../../viewmodels/article/article_cubit.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String id;

  const ArticleDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleCubit()..loadArticle(id),
      child: const _ArticleDetailBody(),
    );
  }
}

class _ArticleDetailBody extends StatelessWidget {
  const _ArticleDetailBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<ArticleCubit, ArticleState>(
        builder: (context, state) {
          if (state.status == ArticleStatus.loading || state.article == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final article = state.article!;
          final padding = AppSpacing.pagePadding(context);

          return Stack(
            children: [
              // ── Scrollable Content ────────────────────────────────
              CustomScrollView(
                slivers: [
                  _buildAppBar(context, state),
                  
                  // Thumbnail
                  SliverToBoxAdapter(
                    child: Container(
                      height: context.scaleHeight(280),
                      width: double.infinity,
                      color: AppColors.card,
                      child: article.thumbnailUrl != null
                          ? Image.network(article.thumbnailUrl!, fit: BoxFit.cover)
                          : Center(
                              child: Icon(
                                LucideIcons.image,
                                color: AppColors.muted,
                                size: context.scaleWidth(48),
                              ),
                            ),
                    ),
                  ),

                  // Content
                  SliverPadding(
                    padding: padding.copyWith(
                      top: context.scaleHeight(24),
                      bottom: context.scaleHeight(100), // Space for floating bar
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Category pill
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.scaleWidth(12),
                                vertical: context.scaleHeight(4),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.silver10,
                                borderRadius: AppRadius.button,
                              ),
                              child: Text(
                                article.category.toUpperCase(),
                                style: AppTextStyles.categoryPill(context).copyWith(
                                  color: AppColors.primaryAccent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.scaleHeight(16)),

                        // Title
                        Text(
                          article.title,
                          style: AppTextStyles.h1(context),
                        ),
                        SizedBox(height: context.scaleHeight(12)),

                        // Meta Row
                        Row(
                          children: [
                            Icon(
                              LucideIcons.clock,
                              size: context.scaleWidth(14),
                              color: AppColors.silverSecondaryLabel,
                            ),
                            SizedBox(width: context.scaleWidth(6)),
                            Text(
                              article.timeAgo,
                              style: AppTextStyles.caption(context).copyWith(
                                color: AppColors.silverSecondaryLabel,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              article.source,
                              style: AppTextStyles.caption(context).copyWith(
                                color: AppColors.primaryAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 48, color: Colors.white10),

                        // Body Text
                        Text(
                          _mockContent,
                          style: AppTextStyles.body(context).copyWith(
                            height: 1.6,
                            color: AppColors.foreground.withValues(alpha: 0.9),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),

              // ── Floating Action Bar ──────────────────────────────
              Positioned(
                bottom: context.scaleHeight(24),
                left: padding.left,
                right: padding.right,
                child: const PageEntranceAnimation(
                  delay: Duration(milliseconds: 400),
                  child: _FloatingActionsBar(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ArticleState state) {
    return SliverAppBar(
      backgroundColor: AppColors.background.withValues(alpha: 0.8),
      floating: true,
      pinned: false,
      leading: IconButton(
        icon: const Icon(LucideIcons.chevronLeft, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            state.isSaved ? LucideIcons.bookmarkCheck : LucideIcons.bookmark,
            color: state.isSaved ? AppColors.primaryAccent : Colors.white,
          ),
          onPressed: () => context.read<ArticleCubit>().toggleSave(),
        ),
        IconButton(
          icon: const Icon(LucideIcons.share2, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  static const String _mockContent = 
    "Artificial intelligence is no longer just a buzzword; it is fundamentally reshaping how we interact with technology and process information. From healthcare to finance, the implications are vast and multifaceted. Experts predict that the next decade will see a surge in specialized AI models that can reason through complex problems with near-human accuracy.\n\n"
    "One of the major hurdles remains the stability of large-scale models. Researchers are exploring new training paradigms that prioritize efficiency over raw parameter count. This shift could lead to more accessible AI tools that run locally on mobile devices without relying purely on cloud compute.\n\n"
    "Ethical considerations also play a critical role in the deployment of these systems. As they become more integrated into critical infrastructure, the transparency of their decision-making processes becomes paramount. Legislation globally is starting to catch up with the pace of innovation, introducing frameworks for accountability and safety.";
}

class _FloatingActionsBar extends StatelessWidget {
  const _FloatingActionsBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(8),
        vertical: context.scaleHeight(8),
      ),
      decoration: BoxDecoration(
        color: AppColors.silverGlass,
        borderRadius: AppRadius.button,
        border: Border.all(color: AppColors.silverBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionButton(
            label: 'Summarize',
            icon: LucideIcons.sparkles,
            onPressed: () {},
          ),
          SizedBox(width: context.scaleWidth(8)),
          _ActionButton(
            label: 'Fact Check',
            icon: LucideIcons.shieldCheck,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PressScaleAnimation(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(12)),
          decoration: BoxDecoration(
            color: AppColors.primaryAccent,
            borderRadius: AppRadius.button,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: AppColors.primaryForeground),
              SizedBox(width: context.scaleWidth(8)),
              Text(
                label,
                style: AppTextStyles.buttonLabel(context).copyWith(
                  color: AppColors.primaryForeground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
