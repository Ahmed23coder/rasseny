import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/service_locator.dart';
import '../../logic/onboarding_cubit.dart';
import '../../logic/onboarding_state.dart';
import '../widgets/onboarding_button.dart';
import '../widgets/onboarding_slide.dart';
import '../widgets/page_indicator.dart';

/// 3-screen onboarding flow with PageView, Cubit, and swipe support.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingCubit>(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToSignIn() {
    // TODO: Replace with actual SignIn route.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const _SignInPlaceholder()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.midnightNavy,
        body: Stack(
          children: [
            // ── Background PageView (Edge-to-Edge) ──
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: cubit.pages.length,
                onPageChanged: cubit.onPageChanged,
                itemBuilder: (context, index) {
                  return OnboardingSlide(content: cubit.pages[index]);
                },
              ),
            ),

            // ── Foreground UI (SafeArea) ──
            SafeArea(
              child: Column(
                children: [
                  // ── Header ──
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.appName,
                          style: GoogleFonts.newsreader(
                            color: AppColors.silver,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // ── Footer: Button + Indicators ──
                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 32, 48),
                        child: Column(
                          children: [
                            // Button
                            Row(
                              children: [
                                if (state.currentPage == 0) ...[
                                  GestureDetector(
                                    onTap: _navigateToSignIn,
                                    child: Text(
                                      AppStrings.skip,
                                      style: GoogleFonts.inter(
                                        color: AppColors.descriptionGrey,
                                        fontSize: 12,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                ],
                                Expanded(
                                  child: OnboardingButton(
                                    isLastPage: state.isLastPage,
                                    onPressed: () {
                                      final shouldNavigate = cubit.nextPage();
                                      if (shouldNavigate) {
                                        _navigateToSignIn();
                                      } else {
                                        _pageController.animateToPage(
                                          state.currentPage + 1,
                                          duration: const Duration(
                                            milliseconds: 400,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Page indicators
                            PageIndicator(
                              currentPage: state.currentPage,
                              pageCount: state.totalPages,
                            ),
                          ],
                        ),
                      );
                    },
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

// ─────────────────────────────────────────────────────────
// Temporary placeholder for sign-in – replace later
// ─────────────────────────────────────────────────────────

class _SignInPlaceholder extends StatelessWidget {
  const _SignInPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.midnightNavy,
      body: const Center(
        child: Text(
          'Sign In Screen',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
