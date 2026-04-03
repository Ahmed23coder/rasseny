import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/navigation/app_router.dart';
import '../../../core/utils/responsive_util.dart';
import '../../../core/utils/app_animations.dart';
import '../../viewmodels/auth/interests_cubit.dart';
import '../../viewmodels/auth/interests_state.dart';
import '../../widgets/auth/auth_header.dart';
import '../../widgets/auth/interest_chip.dart';
import '../../widgets/buttons/error_button.dart';
import '../../widgets/buttons/primary_button.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InterestsCubit(),
      child: const _InterestsView(),
    );
  }
}

class _InterestsView extends StatelessWidget {
  const _InterestsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<InterestsCubit, InterestsState>(
        listener: (context, state) {
          if (state.status == InterestsStatus.success) {
            context.go(AppRouter.shell); // Or main page
          }
        },
        builder: (context, state) {
          final cubit = context.read<InterestsCubit>();

          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(24)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.scaleHeight(16)),
                       const Center(
                        child: AuthHeader(
                          title: "What interests you?",
                          subtitle: "Pick at least 3 topics to personalise your feed.",
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(24)),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Inter', 
                            fontSize: context.scaleFontSize(14),
                            color: AppColors.silverPlaceholder,
                          ),
                          children: [
                            TextSpan(
                              text: "${state.selectedCount}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: state.canSubmit ? AppColors.primaryAccent : Colors.white,
                              ),
                            ),
                            const TextSpan(text: "  /  3 minimum selected"),
                          ],
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(32)),
                      Wrap(
                        spacing: context.scaleWidth(12),
                        runSpacing: context.scaleHeight(12),
                        children: kInterests.map((interest) {
                          return InterestChip(
                            label: interest.label,
                            emoji: interest.emoji,
                            isSelected: state.selectedInterests.contains(interest.label),
                            onTap: () => cubit.toggleInterest(interest.label),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: context.scaleHeight(180)), // Space for bottom CTA
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: context.scaleHeight(160),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.background.withValues(alpha: 0),
                        AppColors.background.withValues(alpha: 0.9),
                        AppColors.background,
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(context.scaleWidth(24)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (state.status == InterestsStatus.error) ...[
                        ErrorButton(
                          label: state.errorMessage ?? "Selection Failed",
                          onPressed: cubit.submit,
                        ),
                      ] else ...[
                        PrimaryButton(
                          label: state.canSubmit ? "Continue" : "Select ${state.remainingNeeded} more topics",
                          isDisabled: !state.canSubmit,
                          isLoading: state.status == InterestsStatus.loading,
                          onPressed: cubit.submit,
                        ),
                      ],
                      SizedBox(height: context.scaleHeight(16)),
                      PressScaleAnimation(
                        onTap: () => context.go(AppRouter.shell),
                        child: Text(
                          "Skip for now",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: context.scaleFontSize(14),
                            color: AppColors.silverPlaceholder,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
