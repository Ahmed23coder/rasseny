import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/navigation/app_router.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/app_animations.dart';
import '../../../core/utils/responsive_util.dart';
import '../../viewmodels/splash/splash_cubit.dart';

/// Splash Screen — Rasseny Intelligence
///
/// Uses [PageEntranceAnimation] for the logo group and a custom
/// loading-bar animation at the bottom, matching the Figma spec.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..initializeApp(),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatefulWidget {
  const _SplashView();

  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView>
    with TickerProviderStateMixin {
  late final AnimationController _introCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _loadingCtrl;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;

  late final Animation<double> _titleOpacity;
  late final Animation<Offset> _titleSlide;

  late final Animation<double> _subtitleOpacity;

  late final Animation<double> _glowScale;
  late final Animation<double> _glowOpacity;

  late final Animation<double> _loadingWidth;

  @override
  void initState() {
    super.initState();

    // Setup sequence for Intro Animations
    _introCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    // 1. Logo Fade and Scale
    _logoScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _introCtrl,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOutBack),
      ),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introCtrl,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );

    // 2. Title Fade-Up
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introCtrl,
        curve: const Interval(0.30, 0.60, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _introCtrl,
        curve: const Interval(0.30, 0.60, curve: Curves.easeOutCubic),
      ),
    );

    // 3. Subtitle Fade-In
    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introCtrl,
        curve: const Interval(0.375, 0.625, curve: Curves.easeOut),
      ),
    );

    // 4. Ambient Glow (Independent looping)
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _glowScale = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );
    _glowOpacity = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    // 5. Progress Bar Sweep
    _loadingCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
    _loadingWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loadingCtrl, curve: Curves.easeInOut),
    );

    // Trigger animations
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _introCtrl.forward();
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) _loadingCtrl.forward();
    });

    _glowCtrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _introCtrl.dispose();
    _glowCtrl.dispose();
    _loadingCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigating) {
          context.go(AppRouter.onboarding);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SizedBox.expand(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // ── 5. Ambient Glow ──
              Positioned(
                top: context.scaleHeight(325.81),
                child: AnimatedBuilder(
                  animation: _glowCtrl,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _glowScale.value,
                      child: Opacity(
                        opacity: _glowOpacity.value,
                        child: child!,
                      ),
                    );
                  },
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 64.0, sigmaY: 64.0),
                    child: Container(
                      width: context.scaleWidth(320.0),
                      height: context.scaleWidth(320.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.silverGlass,
                      ),
                    ),
                  ),
                ),
              ),

              // ── Foreground logo group ──
              Positioned(
                top: context.scaleHeight(395.80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 1. Logo Scale-In
                    AnimatedBuilder(
                      animation: _introCtrl,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _logoScale.value,
                          child: Opacity(
                            opacity: _logoOpacity.value,
                            child: child!,
                          ),
                        );
                      },
                      child: SizedBox(
                        width: context.scaleWidth(96),
                        height: context.scaleWidth(96),
                        child: SvgPicture.asset(
                          'assets/svg/anchor_logo.svg',
                          colorFilter: const ColorFilter.mode(
                            AppColors.primaryAccent,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(24)),
                    
                    // 2. Title Fade-Up
                    AnimatedBuilder(
                      animation: _introCtrl,
                      builder: (context, child) {
                        return SlideTransition(
                          position: _titleSlide,
                          child: Opacity(
                            opacity: _titleOpacity.value,
                            child: child!,
                          ),
                        );
                      },
                      child: Text(
                        'Rasseny',
                        style: AppTextStyles.appName(context).copyWith(
                          fontSize: context.scaleFontSize(30),
                          color: AppColors.foreground,
                        ),
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(8)),
                    
                    // 3. Subtitle Fade-In
                    AnimatedBuilder(
                      animation: _introCtrl,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _subtitleOpacity.value,
                          child: child!,
                        );
                      },
                      child: Text(
                        'INTELLIGENCE',
                        style: AppTextStyles.categoryPill(context).copyWith(
                          fontSize: context.scaleFontSize(12),
                          color: AppColors.silverPlaceholder,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── 4. Progress Bar Sweep ──
              Positioned(
                bottom: context.scaleHeight(72),
                child: AnimatedBuilder(
                  animation: _loadingCtrl,
                  builder: (_, __) => Container(
                    width: context.scaleWidth(107.6) * _loadingWidth.value,
                    height: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      color: AppColors.silverBorder,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
