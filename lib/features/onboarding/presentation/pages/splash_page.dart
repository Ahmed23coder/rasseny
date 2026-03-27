import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/service_locator.dart';
import 'onboarding_page.dart';
import '../../logic/splash_cubit.dart';
import '../../logic/splash_state.dart';

/// Rasseny splash screen – Midnight Navy gradient, anchor logo, brand text.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashCubit>()..startSplash(),
      child: const _SplashView(),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Internal view that owns the animations and listens to BLoC
// ─────────────────────────────────────────────────────────

class _SplashView extends StatefulWidget {
  const _SplashView();

  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView> {
  // Controls for staggered fade-in animations
  bool _showLogo = false;
  bool _showTitle = false;
  bool _showSubtitle = false;
  bool _showAccents = false;
  bool _showDots = false;

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Preload onboarding background images so they display instantly
    // when navigating to OnboardingPage
    precacheImage(
      const AssetImage('assets/images/onboarding_global.png'),
      context,
    );
    precacheImage(const AssetImage('assets/images/onboarding_ai.png'), context);
    precacheImage(
      const AssetImage('assets/images/onboarding_verified.png'),
      context,
    );
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() => _showAccents = true);

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _showLogo = true);

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _showTitle = true);

    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    setState(() => _showSubtitle = true);

    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    setState(() => _showDots = true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is NavigateToOnboarding) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const OnboardingPage()),
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.2,
              colors: [
                AppColors.gradientCenter,
                AppColors.gradientMiddle,
                AppColors.gradientEdge,
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // ── Corner Accents (top-left) ──
              _buildCornerAccent(
                top: 48,
                left: 48,
                visible: _showAccents,
                isTopLeft: true,
              ),

              // ── Corner Accents (bottom-right) ──
              _buildCornerAccent(
                bottom: 48,
                right: 48,
                visible: _showAccents,
                isTopLeft: false,
              ),

              // ── Center Identity Cluster ──
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    AnimatedOpacity(
                      opacity: _showLogo ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      child: SvgPicture.asset(
                        AppStrings.logoPath,
                        width: 62.8,
                        height: 70.8,
                        colorFilter: const ColorFilter.mode(
                          AppColors.silver,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Brand Title
                    AnimatedOpacity(
                      opacity: _showTitle ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      child: Text(
                        AppStrings.appName,
                        style: GoogleFonts.newsreader(
                          color: AppColors.silver,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Subtitle
                    AnimatedOpacity(
                      opacity: _showSubtitle ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      child: Opacity(
                        opacity: 0.6,
                        child: Text(
                          AppStrings.appSubtitle,
                          style: GoogleFonts.inter(
                            color: AppColors.subtitleBlue,
                            fontSize: 10.4,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 4.16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Loading Indicator Dots ──
              Positioned(
                bottom: 96,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: _showDots ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dot(opacity: 0.2),
                      const SizedBox(width: 8),
                      _dot(opacity: 0.4),
                      const SizedBox(width: 8),
                      _dot(opacity: 0.2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helpers ──

  Widget _buildCornerAccent({
    double? top,
    double? left,
    double? bottom,
    double? right,
    required bool visible,
    required bool isTopLeft,
  }) {
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: AnimatedOpacity(
        opacity: visible ? 0.2 : 0.0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: SizedBox(
          width: 64,
          height: 64,
          child: CustomPaint(
            painter: _CornerAccentPainter(isTopLeft: isTopLeft),
          ),
        ),
      ),
    );
  }

  Widget _dot({required double opacity}) {
    return Opacity(
      opacity: opacity,
      child: Container(width: 4, height: 4, color: AppColors.silver),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Custom painter for the L-shaped corner accents
// ─────────────────────────────────────────────────────────

class _CornerAccentPainter extends CustomPainter {
  _CornerAccentPainter({required this.isTopLeft});

  final bool isTopLeft;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.silver
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    if (isTopLeft) {
      // Horizontal line from top-left going right
      canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
      // Vertical line from top-left going down
      canvas.drawLine(Offset.zero, Offset(0, size.height), paint);
    } else {
      // Horizontal line from bottom-right going left
      canvas.drawLine(
        Offset(0, size.height),
        Offset(size.width, size.height),
        paint,
      );
      // Vertical line from bottom-right going up
      canvas.drawLine(
        Offset(size.width, 0),
        Offset(size.width, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
