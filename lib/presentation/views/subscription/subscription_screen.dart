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
import '../../viewmodels/subscription/subscription_cubit.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionCubit(),
      child: const _SubscriptionBody(),
    );
  }
}

class _SubscriptionBody extends StatelessWidget {
  const _SubscriptionBody();

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
          'Subscription',
          style: AppTextStyles.h2(context),
        ),
      ),
      body: BlocBuilder<SubscriptionCubit, SubscriptionState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: padding.copyWith(top: context.scaleHeight(16)),
            child: Column(
              children: [
                _buildHeader(context),
                SizedBox(height: context.scaleHeight(24)),
                
                // Plans
                Row(
                  children: [
                    Expanded(
                      child: _PlanCard(
                        title: 'Free',
                        price: '\$0',
                        isSelected: state.selectedPlanIndex == 0,
                        onTap: () => context.read<SubscriptionCubit>().selectPlan(0),
                      ),
                    ),
                    SizedBox(width: context.scaleWidth(16)),
                    Expanded(
                      child: _PlanCard(
                        title: 'Pro',
                        price: '\$4.99/mo',
                        isSelected: state.selectedPlanIndex == 1,
                        isPro: true,
                        onTap: () => context.read<SubscriptionCubit>().selectPlan(1),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: context.scaleHeight(32)),
                _buildFeatureList(context),
                
                SizedBox(height: context.scaleHeight(40)),
                PressScaleAnimation(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: context.scaleHeight(56),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccent,
                      borderRadius: AppRadius.button,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Upgrade to Pro',
                      style: AppTextStyles.buttonLabel(context).copyWith(
                        color: AppColors.primaryForeground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.bottomScrollPadding(context)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Icon(
          LucideIcons.sparkles,
          size: context.scaleWidth(48),
          color: AppColors.primaryAccent,
        ),
        SizedBox(height: context.scaleHeight(16)),
        Text(
          'Unleash the Power of AI',
          textAlign: TextAlign.center,
          style: AppTextStyles.h2(context),
        ),
        SizedBox(height: context.scaleHeight(8)),
        Text(
          'Get premium features with Rasseny Pro',
          textAlign: TextAlign.center,
          style: AppTextStyles.body(context).copyWith(
            color: AppColors.silverSecondaryLabel,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureList(BuildContext context) {
    final features = [
      'Unlimited AI Summaries',
      'Advanced Fact-Checking',
      'Exclusive Insights',
      'Ad-free Experience',
      'Priority Support',
    ];

    return Column(
      children: [
        Row(
          children: [
            Text('WHAT YOU GET', style: AppTextStyles.sectionLabel(context)),
            const Spacer(),
          ],
        ),
        SizedBox(height: context.scaleHeight(16)),
        ...features.map((f) => Padding(
          padding: EdgeInsets.only(bottom: context.scaleHeight(12)),
          child: Row(
            children: [
              Icon(
                LucideIcons.circleCheck,
                color: AppColors.primaryAccent,
                size: context.scaleWidth(18),
              ),
              SizedBox(width: context.scaleWidth(12)),
              Text(
                f,
                style: AppTextStyles.body(context).copyWith(
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final bool isSelected;
  final bool isPro;
  final VoidCallback onTap;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.isSelected,
    this.isPro = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PressScaleAnimation(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(context.scaleWidth(20)),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.silverGlass : AppColors.card,
          borderRadius: AppRadius.card,
          border: Border.all(
            color: isSelected ? AppColors.primaryAccent : AppColors.silverBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPro)
              Container(
                margin: EdgeInsets.only(bottom: context.scaleHeight(8)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryAccent.withAlpha(26),
                  borderRadius: AppRadius.button,
                ),
                child: Text(
                  'POPULAR',
                  style: AppTextStyles.microText(context).copyWith(
                    color: AppColors.primaryAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Text(
              title,
              style: AppTextStyles.h3(context).copyWith(
                color: isSelected ? AppColors.foreground : AppColors.silverSecondaryLabel,
              ),
            ),
            SizedBox(height: context.scaleHeight(4)),
            Text(
              price,
              style: AppTextStyles.h2(context).copyWith(
                fontSize: context.scaleFontSize(18),
                color: AppColors.primaryAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
