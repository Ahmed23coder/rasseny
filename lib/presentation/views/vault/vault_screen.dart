import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';
import '../../viewmodels/vault/vault_cubit.dart';
import '../../widgets/cards/article_card.dart';
import '../../widgets/inputs/app_search_bar.dart';

class VaultScreen extends StatelessWidget {
  const VaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VaultCubit()..load(),
      child: const _VaultBody(),
    );
  }
}

class _VaultBody extends StatefulWidget {
  const _VaultBody();

  @override
  State<_VaultBody> createState() => _VaultBodyState();
}

class _VaultBodyState extends State<_VaultBody> {
  bool _isEditing = false;

  void _toggleEdit() {
    setState(() => _isEditing = !_isEditing);
    if (!_isEditing) {
      context.read<VaultCubit>().clearSelection();
    }
  }

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
          'Vault',
          style: AppTextStyles.h2(context),
        ),
        actions: [
          if (_isEditing)
            IconButton(
              icon: Icon(
                LucideIcons.trash2,
                color: AppColors.destructive,
                size: context.scaleWidth(20),
              ),
              onPressed: () {
                context.read<VaultCubit>().deleteSelected();
                _toggleEdit();
              },
            ),
          TextButton(
            onPressed: _toggleEdit,
            child: Text(
              _isEditing ? 'Done' : 'Edit',
              style: AppTextStyles.buttonLabel(context).copyWith(
                color: AppColors.primaryAccent,
              ),
            ),
          ),
          SizedBox(width: context.scaleWidth(8)),
        ],
      ),
      body: BlocBuilder<VaultCubit, VaultState>(
        builder: (context, state) {
          if (state.status == VaultStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.savedArticles.isEmpty) {
            return _buildEmptyState(context);
          }

          return CustomScrollView(
            slivers: [
              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: padding.copyWith(bottom: context.scaleHeight(16)),
                  child: const AppSearchBar(hintText: 'Search within vault...'),
                ),
              ),

              // Article Grid/List
              SliverPadding(
                padding: padding.copyWith(
                  bottom: AppSpacing.bottomScrollPadding(context),
                ),
                sliver: SliverList.separated(
                  itemCount: state.savedArticles.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: AppSpacing.listGap(context)),
                  itemBuilder: (context, index) {
                    final article = state.savedArticles[index];
                    final isSelected = state.selectedIds.contains(article.id);

                    return PageEntranceAnimation(
                      delay: Duration(milliseconds: index * 50),
                      child: Stack(
                        children: [
                          ArticleCard(
                            title: article.title,
                            category: article.category,
                            source: article.source,
                            timeAgo: article.timeAgo,
                            thumbnailUrl: article.thumbnailUrl,
                            onTap: _isEditing
                                ? () => context.read<VaultCubit>().toggleSelection(article.id)
                                : () => context.push('/article/${article.id}'),
                          ),
                          if (_isEditing)
                            Positioned(
                              top: context.scaleHeight(12),
                              right: context.scaleWidth(12),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.primaryAccent : Colors.black26,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Icon(
                                  LucideIcons.check,
                                  size: context.scaleWidth(12),
                                  color: isSelected ? AppColors.primaryForeground : Colors.transparent,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
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
            LucideIcons.bookmark,
            size: context.scaleWidth(64),
            color: AppColors.muted,
          ),
          SizedBox(height: context.scaleHeight(24)),
          Text(
            'The Vault is Empty',
            style: AppTextStyles.h2(context).copyWith(color: AppColors.muted),
          ),
          SizedBox(height: context.scaleHeight(8)),
          Text(
            'Articles you save will appear here.',
            style: AppTextStyles.body(context).copyWith(color: AppColors.silverPlaceholder),
          ),
        ],
      ),
    );
  }
}
