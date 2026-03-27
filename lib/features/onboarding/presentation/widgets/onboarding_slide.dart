import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../logic/onboarding_cubit.dart';

/// A single onboarding slide displaying background image, title, and description.
class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({super.key, required this.content});

  final OnboardingContent content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Background Image (monochrome navy tint) ──
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(content.imagePath),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                opacity: 0.25,
                colorFilter: const ColorFilter.mode(
                  AppColors.midnightNavy, // deep navy tint
                  BlendMode.color,
                ),
              ),
            ),
          ),
        ),

        // ── Gradient overlay for readability ──
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.midnightNavy.withValues(alpha: 0.0),
                  AppColors.midnightNavy.withValues(alpha: 0.5),
                  AppColors.midnightNavy.withValues(alpha: 0.85),
                  AppColors.midnightNavy,
                ],
                stops: const [0.0, 0.35, 0.55, 0.7],
              ),
            ),
          ),
        ),

        // ── Text Content (SafeArea + Flex Layout) ──
        SafeArea(
          child: Column(
            children: [
              const Spacer(), // Pushes text to the bottom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Optional label (e.g. "FINAL VERIFICATION") ──
                    if (content.label != null) ...[
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        duration: const Duration(milliseconds: 600),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 1,
                              color: AppColors.accentBlue,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              content.label!,
                              style: GoogleFonts.inter(
                                color: AppColors.accentBlue,
                                fontSize: 11.2 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.03), // 24
                    ],

                    // ── Accent bar (only when no label) ──
                    if (content.label == null) ...[
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        duration: const Duration(milliseconds: 600),
                        child: Container(width: 48, height: 4, color: AppColors.silver),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04), // 36
                    ],

                    // ── Title ──
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 600),
                      child: _buildTitle(),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                    // ── Description ──
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        content.description,
                        style: GoogleFonts.newsreader(
                          color: AppColors.descriptionGrey,
                          fontSize: 18 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.w400,
                          fontStyle: content.label == null
                              ? FontStyle.italic
                              : FontStyle.normal,
                          height: 1.625,
                        ),
                      ),
                    ),

                    // Empty space exactly matching the height of the page footer
                    // to prevent any overlap: Bottom padding (48) + Button (56) +
                    // Spacing (32) + Indicators (~10) + Extra buffer = ~160px
                    SizedBox(height: SizeConfig.screenHeight * 0.18), // 160
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    if (content.titleItalicPart != null) {
      // Two-line: bold first line + italic second line (Screen 2)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content.title,
            style: GoogleFonts.newsreader(
              color: AppColors.headlineBlue,
              fontSize: 48 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
          Text(
            content.titleItalicPart!,
            style: GoogleFonts.newsreader(
              color: AppColors.silver,
              fontSize: 48 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              height: 1.25,
            ),
          ),
        ],
      );
    }

    // Single or multi-line title
    final isItalic = content.label != null;
    return Text(
      content.title,
      style: GoogleFonts.newsreader(
        color: AppColors.headlineBlue,
        fontSize: 48 * SizeConfig.textMultiplier,
        fontWeight: isItalic ? FontWeight.w400 : FontWeight.w800,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        height: 1.25,
        letterSpacing: -1.2,
      ),
    );
  }
}
