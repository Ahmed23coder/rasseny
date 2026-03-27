import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/size_config.dart';
import '../../logic/auth_bloc.dart';
import '../../logic/auth_event.dart';

/// Authentication success screen (Figma Node 17-175).
class AuthSuccessPage extends StatelessWidget {
  const AuthSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04), // ~32

              // ── Illustration container ──
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  color: AppColors.inputFillDark.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(48),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.inputBorderBlue.withValues(alpha: 0.15),
                      AppColors.inputFillDark,
                    ],
                  ),
                  border: Border.all(
                    color: AppColors.ghostBorder.withValues(alpha: 0.06),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 60,
                      offset: const Offset(0, 30),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Inner rounded card
                    Container(
                      width: 200,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: AppColors.inputBorderBlue.withValues(alpha: 0.15),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.inputBorderBlue.withValues(alpha: 0.1),
                            AppColors.inputFillDark.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppStrings.logoPath,
                            width: 32,
                            colorFilter: const ColorFilter.mode(
                              AppColors.labelBlue,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'SUCCESS',
                            style: GoogleFonts.inter(
                              color: AppColors.silver,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'SAFE WORK',
                            style: GoogleFonts.inter(
                              color: AppColors.silver.withValues(alpha: 0.4),
                              fontSize: 10,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Anchor overlay at bottom
                    Positioned(
                      bottom: 16,
                      left: 88,
                      child: SvgPicture.asset(
                        AppStrings.logoPath,
                        width: 32,
                        colorFilter: ColorFilter.mode(
                          AppColors.labelBlue.withValues(alpha: 0.4),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // ── Verified badge ──
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(
                    color: AppColors.inputBorderBlue.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  AppStrings.authVerified,
                  style: GoogleFonts.inter(
                    color: AppColors.labelBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.65,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                AppStrings.connectionAnchored,
                textAlign: TextAlign.center,
                style: GoogleFonts.newsreader(
                  color: AppColors.textPrimary,
                  fontSize: 56 * SizeConfig.textMultiplier,
                  fontStyle: FontStyle.italic,
                  letterSpacing: -2.8,
                  height: 1.07,
                ),
              ),
              const SizedBox(height: 16),

              // Subtitle
              Text(
                AppStrings.successSubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppColors.silver.withValues(alpha: 0.6),
                  fontSize: 16 * SizeConfig.textMultiplier,
                  height: 1.625,
                ),
              ),
              const SizedBox(height: 40),

              // Encryption detail
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar placeholder
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.inputFillDark,
                      border: Border.all(
                        color: AppColors.ghostBorder.withValues(alpha: 0.15),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.shield_outlined,
                        color: AppColors.labelBlue,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    AppStrings.securedEncryption,
                    style: GoogleFonts.inter(
                      color: AppColors.silver.withValues(alpha: 0.8),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // CTA Button
              SizedBox(
                width: 200,
                child: Material(
                  borderRadius: BorderRadius.circular(9999),
                  color: AppColors.navyButton,
                  child: InkWell(
                    onTap: () {
                      context.read<AuthBloc>().add(const SuccessGetStartedPressed());
                    },
                    borderRadius: BorderRadius.circular(9999),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.getStarted,
                            style: GoogleFonts.inter(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.arrow_forward,
                            color: AppColors.textPrimary,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Edition footer
              Text(
                'THE OBSIDIAN CURATOR — EDITION 2024',
                style: GoogleFonts.inter(
                  color: AppColors.silver.withValues(alpha: 0.25),
                  fontSize: 10 * SizeConfig.textMultiplier,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
