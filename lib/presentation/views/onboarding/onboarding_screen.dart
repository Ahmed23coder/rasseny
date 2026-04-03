import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/navigation/app_router.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/responsive_util.dart';
import '../../viewmodels/onboarding/onboarding_cubit.dart';
import '../../viewmodels/onboarding/onboarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final overlays = [
      {
        'title': 'Intelligence,\nReimagined.',
        'subtitle':
            'Your personalized news experience powered by insight and clarity.',
        'buttonText': 'Next',
      },
      {
        'title': 'Curated For You.',
        'subtitle':
            'AI-driven editorial picks tailored to your interests and worldview.',
        'buttonText': 'Continue',
      },
      {
        'title': 'Stay Ahead.\nStay Informed.',
        'subtitle':
            'Breaking stories, deep analysis, and perspectives that matter.',
        'buttonText': 'Get Started',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Layer 1: Smooth Parallax Background
          AnimatedBuilder(
            animation: cubit.pageController,
            builder: (context, child) {
              double page = 0.0;
              if (cubit.pageController.hasClients) {
                page = cubit.pageController.page ?? 0.0;
              }
              final opacity1 = (1 - (page - 0).abs()).clamp(0.0, 1.0);
              final opacity2 = (1 - (page - 1).abs()).clamp(0.0, 1.0);
              final opacity3 = (1 - (page - 2).abs()).clamp(0.0, 1.0);

              return Stack(
                fit: StackFit.expand,
                children: [
                  if (opacity1 > 0)
                    Opacity(
                      opacity: opacity1,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Opacity(
                            opacity: 0.40, // opacity-40
                            child: Image.asset(
                              'assets/images/onboarding_bg_1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4), // backdrop-blur-sm
                              child: Container(
                                color: AppColors.background.withValues(alpha: 0.4), // bg-[#102A43]/40
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (opacity2 > 0)
                    Opacity(
                      opacity: opacity2,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Opacity(
                            opacity: 0.30, // opacity-30
                            child: Image.asset(
                              'assets/images/onboarding_bg_2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4), // backdrop-blur-sm
                              child: Container(
                                color: AppColors.background.withValues(alpha: 0.5), // bg-[#102A43]/50
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (opacity3 > 0)
                    Opacity(
                      opacity: opacity3,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Opacity(
                            opacity: 0.35, // opacity-35
                            child: Image.asset(
                              'assets/images/onboarding_bg_3.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4), // backdrop-blur-sm
                              child: Container(
                                color: AppColors.background.withValues(alpha: 0.45), // bg-[#102A43]/45
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),

          // Layer 2: Sliding Page Content
          PageView(
            controller: cubit.pageController,
            onPageChanged: cubit.onPageChanged,
            physics: const BouncingScrollPhysics(),
            children: const [
              _OnboardingPageOne(),
              _OnboardingPageTwo(),
              _OnboardingPageThree(),
            ],
          ),
          // Layer 3: Static global overlay
          _OnboardingOverlay(overlays: overlays),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// SHARED OVERLAY WIDGET FOR PROGRESS & CTA
// ──────────────────────────────────────────────────────────────────
class _OnboardingOverlay extends StatelessWidget {
  final List<Map<String, String>> overlays;

  const _OnboardingOverlay({required this.overlays});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: context.scaleHeight(348),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.background, // 100%
              AppColors.background.withValues(alpha: 0.9), // 90%
              Colors.transparent, // 0%
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        padding: EdgeInsets.only(
          top: context.scaleHeight(80),
          bottom: context.scaleHeight(40), // SafeArea bottom padding
        ),
        child: Column(
          children: [
            // Title & Subtitle cross-fading based on finger position offset
            SizedBox(
              width: context.scaleWidth(329),
              child: AnimatedBuilder(
                animation: cubit.pageController,
                builder: (context, child) {
                  double page = 0.0;
                  if (cubit.pageController.hasClients) {
                    page = cubit.pageController.page ?? 0.0;
                  }
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: List.generate(3, (index) {
                      double opacity = (1 - (page - index).abs()).clamp(
                        0.0,
                        1.0,
                      );
                      if (opacity == 0) return const SizedBox.shrink();

                      final slideOffset = (page - index) * 50.0;
                      return Transform.translate(
                        offset: Offset(0, slideOffset),
                        child: Opacity(
                          opacity: opacity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                overlays[index]['title']!,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.h1(context).copyWith(
                                  fontSize: context.scaleFontSize(30),
                                  color: AppColors.foreground,
                                ),
                              ),
                              SizedBox(height: context.scaleHeight(12)),
                              Text(
                                overlays[index]['subtitle']!,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.body(context).copyWith(
                                  fontSize: context.scaleFontSize(14),
                                  color: AppColors.primaryAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            const Spacer(),
            // Progress Indicator and CTA
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        final isActive = index == state.currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(
                            horizontal: context.scaleWidth(4),
                          ),
                          height: context.scaleHeight(8),
                          width: isActive
                              ? context.scaleWidth(32)
                              : context.scaleWidth(8),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.primaryAccent
                                : AppColors.primaryAccent.withValues(
                                    alpha: 0.3,
                                  ),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: context.scaleHeight(24)),
                    _BouncingButton(
                      onTap: () {
                        if (state.isLastPage) {
                          context.go(AppRouter.login);
                        } else {
                          cubit.nextPage();
                        }
                      },
                      child: Container(
                        width: context.scaleWidth(329),
                        height: context.scaleHeight(56),
                        decoration: BoxDecoration(
                          color: AppColors.primaryAccent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            overlays[state.currentPage]['buttonText']!,
                            key: ValueKey<String>(
                              overlays[state.currentPage]['buttonText']!,
                            ),
                            style: AppTextStyles.buttonLabel(context).copyWith(
                              color: AppColors.background,
                              fontSize: context.scaleFontSize(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// PAGE 1 WIDGET
// ──────────────────────────────────────────────────────────────────
class _OnboardingPageOne extends StatefulWidget {
  const _OnboardingPageOne();

  @override
  State<_OnboardingPageOne> createState() => _OnboardingPageOneState();
}

class _OnboardingPageOneState extends State<_OnboardingPageOne>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _glassScale;
  late final Animation<Offset> _pillLeftSlide;
  late final Animation<Offset> _pillRightSlide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    // Glass Card Spring
    _glassScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );
    // Left pill slide
    _pillLeftSlide =
        Tween<Offset>(begin: const Offset(-0.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.3, 0.8, curve: Curves.easeOutCubic),
          ),
        );
    // Right pill slide
    _pillRightSlide =
        Tween<Offset>(begin: const Offset(0.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.4, 0.9, curve: Curves.easeOutCubic),
          ),
        );

    // Initial check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (context.read<OnboardingCubit>().state.currentPage == 0) {
        _ctrl.forward();
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (prev, curr) => prev.currentPage != curr.currentPage,
      listener: (context, state) {
        if (state.currentPage == 0) {
          _ctrl.forward(from: 0.0);
        }
      },
      child: Stack(
        children: [
          // Central glass icon
          Positioned(
            top: context.scaleHeight(330),
            left: context.scaleWidth(100),
            child: ScaleTransition(
              scale: _glassScale,
              child: Container(
                width: context.scaleWidth(192),
                height: context.scaleWidth(192),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.silverFaint,
                  border: Border.all(
                    color: AppColors.silverBorder,
                    width: 1.185,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 50,
                      offset: const Offset(0, 25),
                    ),
                  ],
                ),
                child: Center(
                  child: SizedBox(
                    width: context.scaleWidth(110),
                    height: context.scaleHeight(110),
                    child: Icon(
                      Icons.electric_bolt_rounded,
                      color: AppColors.foreground,
                      size: context.scaleWidth(48),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Top Left Pill
          Positioned(
            top: context.scaleHeight(96),
            left: context.scaleWidth(24),
            child: SlideTransition(
              position: _pillLeftSlide,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: context.scaleHeight(34),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scaleWidth(17),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.silverGlass,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.silverBorder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: context.scaleWidth(14),
                          color: AppColors.primaryAccent,
                        ),
                        SizedBox(width: context.scaleWidth(8)),
                        Text(
                          'AI-Powered',
                          style: AppTextStyles.caption(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Bottom Right Pill
          Positioned(
            top: context.scaleHeight(
              418,
            ), // Figma: 738 is below mask, adjust slightly
            left: context.scaleWidth(245),
            child: SlideTransition(
              position: _pillRightSlide,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: context.scaleHeight(34),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scaleWidth(17),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.silverGlass,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.silverBorder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.analytics_outlined,
                          size: context.scaleWidth(14),
                          color: AppColors.primaryAccent,
                        ),
                        SizedBox(width: context.scaleWidth(8)),
                        Text(
                          'Deep Analysis',
                          style: AppTextStyles.caption(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// PAGE 2 WIDGET
// ──────────────────────────────────────────────────────────────────
class _OnboardingPageTwo extends StatefulWidget {
  const _OnboardingPageTwo();

  @override
  State<_OnboardingPageTwo> createState() => _OnboardingPageTwoState();
}

class _OnboardingPageTwoState extends State<_OnboardingPageTwo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _badgeScale;
  late final Animation<Offset> _pill1Slide;
  late final Animation<Offset> _pill2Slide;
  late final Animation<Offset> _pill3Slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _badgeScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _pill1Slide = Tween<Offset>(begin: const Offset(0, 1.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
          ),
        );
    _pill2Slide = Tween<Offset>(begin: const Offset(0, 1.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
          ),
        );
    _pill3Slide = Tween<Offset>(begin: const Offset(0, 1.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (context.read<OnboardingCubit>().state.currentPage == 1) {
        _ctrl.forward();
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (prev, curr) => prev.currentPage != curr.currentPage,
      listener: (context, state) {
        if (state.currentPage == 1) {
          _ctrl.forward(from: 0.0);
        }
      },
      child: Stack(
        children: [
          // Content
          Positioned(
            top: context.scaleHeight(112),
            left: 0,
            right: 0,
            child: SizedBox(
              height: context.scaleHeight(321),
              child: Stack(
                children: [
                  // Background label
                  Positioned(
                    top: 0,
                    left: context.scaleWidth(90),
                    child: ScaleTransition(
                      scale: _badgeScale,
                      child: Container(
                        height: context.scaleHeight(42),
                        width: context.scaleWidth(213),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.silverFaint,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: AppColors.silverBorder),
                        ),
                        child: Text(
                          'CURATED FOR YOUR INTERESTS',
                          style: AppTextStyles.caption(context).copyWith(
                            letterSpacing: 0.5,
                            color: AppColors.silverSecondaryLabel,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Pill 1: Technology
                  Positioned(
                    top: context.scaleHeight(58),
                    left: context.scaleWidth(56),
                    child: SlideTransition(
                      position: _pill1Slide,
                      child: const _TopicPill(letter: 'T', title: 'TECHNOLOGY'),
                    ),
                  ),
                  // Pill 2: Science
                  Positioned(
                    top: context.scaleHeight(148),
                    left: context.scaleWidth(56),
                    child: SlideTransition(
                      position: _pill2Slide,
                      child: const _TopicPill(letter: 'S', title: 'SCIENCE'),
                    ),
                  ),
                  // Pill 3: Finance
                  Positioned(
                    top: context.scaleHeight(238),
                    left: context.scaleWidth(56),
                    child: SlideTransition(
                      position: _pill3Slide,
                      child: const _TopicPill(letter: 'F', title: 'FINANCE'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicPill extends StatelessWidget {
  final String letter;
  final String title;

  const _TopicPill({required this.letter, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: context.scaleWidth(280),
          height: context.scaleHeight(78),
          padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(25)),
          decoration: BoxDecoration(
            color: AppColors.silverGlass,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.silverBorder),
          ),
          child: Row(
            children: [
              Container(
                width: context.scaleWidth(40),
                height: context.scaleWidth(40),
                decoration: BoxDecoration(
                  color: AppColors.silverFaint,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  letter,
                  style: AppTextStyles.body(context).copyWith(
                    color: AppColors.silverSecondaryLabel,
                    fontSize: context.scaleFontSize(12),
                  ),
                ),
              ),
              SizedBox(width: context.scaleWidth(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.caption(context).copyWith(
                        letterSpacing: 0.5,
                        color: AppColors.primaryAccent,
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(8)),
                    Container(
                      height: context.scaleHeight(6),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.silverFaint,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(4)),
                    Container(
                      height: context.scaleHeight(6),
                      width: context.scaleWidth(130),
                      decoration: BoxDecoration(
                        color: AppColors.silverGlass,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// PAGE 3 WIDGET
// ──────────────────────────────────────────────────────────────────
class _OnboardingPageThree extends StatefulWidget {
  const _OnboardingPageThree();

  @override
  State<_OnboardingPageThree> createState() => _OnboardingPageThreeState();
}

class _OnboardingPageThreeState extends State<_OnboardingPageThree>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _globeScale;
  late final Animation<Offset> _tag1Slide;
  late final Animation<Offset> _tag2Slide;
  late final Animation<Offset> _tag3Slide;
  late final Animation<double> _tagOpacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _globeScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );

    _tagOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.5, 0.9, curve: Curves.easeIn),
      ),
    );

    _tag1Slide = Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
          ),
        );
    _tag2Slide = Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.5, 0.9, curve: Curves.easeOutCubic),
          ),
        );
    _tag3Slide = Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (context.read<OnboardingCubit>().state.currentPage == 2) {
        _ctrl.forward();
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (prev, curr) => prev.currentPage != curr.currentPage,
      listener: (context, state) {
        if (state.currentPage == 2) {
          _ctrl.forward(from: 0.0);
        }
      },
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) => Stack(
          children: [
            Positioned(
              top: context.scaleHeight(327),
              left: context.scaleWidth(88),
              child: SizedBox(
                width: context.scaleWidth(215),
                height: context.scaleHeight(197),
                child: Stack(
                  children: [
                    // Top Pills row
                    Positioned(
                      top: context.scaleHeight(168),
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SlideTransition(
                            position: _tag1Slide,
                            child: Opacity(
                              opacity: _tagOpacity.value,
                              child: const _StatusPill(text: 'LIVE'),
                            ),
                          ),
                          SizedBox(width: context.scaleWidth(8)),
                          SlideTransition(
                            position: _tag2Slide,
                            child: Opacity(
                              opacity: _tagOpacity.value,
                              child: const _StatusPill(text: '24/7'),
                            ),
                          ),
                          SizedBox(width: context.scaleWidth(8)),
                          SlideTransition(
                            position: _tag3Slide,
                            child: Opacity(
                              opacity: _tagOpacity.value,
                              child: const _StatusPill(text: 'GLOBAL'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Glowing Central Icon
                    Positioned(
                      top: 0,
                      left: context.scaleWidth(35),
                      child: ScaleTransition(
                        scale: _globeScale,
                        child: SizedBox(
                          width: context.scaleWidth(144),
                          height: context.scaleWidth(144),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Blur glow
                              Container(
                                width: context.scaleWidth(216),
                                height: context.scaleWidth(216),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryAccent.withValues(
                                    alpha: 0.05,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryAccent.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 40,
                                      spreadRadius: -36,
                                    ),
                                  ],
                                ),
                              ),
                              // Circle border
                              ClipRRect(
                                borderRadius: BorderRadius.circular(9999),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(
                                    width: context.scaleWidth(144),
                                    height: context.scaleWidth(144),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.silverGlass,
                                      border: Border.all(
                                        color: AppColors.silverBorder,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons
                                          .public, // Fallback icon instead of svg for now
                                      size: context.scaleWidth(56),
                                      color: AppColors.primaryAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String text;

  const _StatusPill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.scaleHeight(29),
      padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(12)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.silverGlass,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.silverFaint), // 0.1 alpha
      ),
      child: Text(
        text,
        style: AppTextStyles.caption(context).copyWith(
          letterSpacing: 1.0,
          color: AppColors.silverSecondaryLabel, // 0.6 alpha
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// BOUNCING BUTTON WIDGET
// ──────────────────────────────────────────────────────────────────
class _BouncingButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _BouncingButton({required this.child, required this.onTap});

  @override
  State<_BouncingButton> createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<_BouncingButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
