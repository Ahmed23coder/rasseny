import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/radius/app_radius.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';

/// News article card with thumbnail, category, title, and meta row.
class ArticleCard extends StatelessWidget {
  final String title;
  final String category;
  final String source;
  final String timeAgo;
  final String? thumbnailUrl;
  final VoidCallback? onTap;

  const ArticleCard({
    super.key,
    required this.title,
    required this.category,
    required this.source,
    required this.timeAgo,
    this.thumbnailUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final thumbSize = context.scaleWidth(88);

    return PressScaleAnimation(
      onTap: onTap,
      scaleOnPress: 0.98,
      child: Container(
        padding: EdgeInsets.all(context.scaleWidth(14)),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: AppRadius.card,
          border: Border.all(color: AppColors.silverBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Thumbnail ─────────────────────────────────────────
            ClipRRect(
              borderRadius: AppRadius.imageThumbnail,
              child: Container(
                width: thumbSize,
                height: thumbSize,
                color: AppColors.secondarySurface,
                child: thumbnailUrl != null
                    ? Image.network(
                        thumbnailUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _placeholderIcon(thumbSize),
                      )
                    : _placeholderIcon(thumbSize),
              ),
            ),
            SizedBox(width: context.scaleWidth(12)),

            // ── Text content ──────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  Text(
                    category.toUpperCase(),
                    style: AppTextStyles.caption(context).copyWith(
                      color: AppColors.accentBlue,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),

                  // Title
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.h4CardHeadline(context),
                  ),
                  SizedBox(height: context.scaleHeight(8)),

                  // Meta row
                  Text(
                    '$source  •  $timeAgo',
                    style: AppTextStyles.caption(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderIcon(double size) {
    return Center(
      child: Icon(
        Icons.article_outlined,
        size: size * 0.4,
        color: AppColors.muted,
      ),
    );
  }
}
