import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/size_config.dart';
import '../../logic/auth_cubit.dart';
import '../../logic/auth_state.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';

/// Forgot Password screen (Figma Node 17-287).
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError &&
            state.previousState is ForgotPasswordState) {
          setState(() => _errorMessage = state.message);
        } else {
          setState(() => _errorMessage = null);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldDark,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.08), // 64

                  // Rasseny brand
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      AppStrings.brandName,
                      style: GoogleFonts.newsreader(
                        color: AppColors.silver.withValues(alpha: 0.7),
                        fontSize: 40 * SizeConfig.textMultiplier,
                        fontStyle: FontStyle.italic,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04), // 32

                  // ── Main card ──
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    border: Border.all(
                      color: AppColors.ghostBorder.withValues(alpha: 0.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 80,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // L-shaped corner accent
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 2,
                          height: 32,
                          color: AppColors.accentGold.withValues(alpha: 0.6),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 12,
                          height: 2,
                          color: AppColors.accentGold.withValues(alpha: 0.6),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Title
                            Text(
                              AppStrings.lostYourHarbor,
                              style: GoogleFonts.newsreader(
                                color: AppColors.textPrimary,
                                fontSize: 28 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.7,
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.01), // 8

                            // Subtitle
                            Text(
                              AppStrings.forgotSubtitle,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.newsreader(
                                color: AppColors.silver.withValues(alpha: 0.6),
                                fontSize: 18 * SizeConfig.textMultiplier,
                                fontStyle: FontStyle.italic,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.05), // 40

                            // Email field
                            AuthTextField(
                              label: AppStrings.registryEmail,
                              hint: AppStrings.emailPlaceholder,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              errorText: _errorMessage,
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.04), // 32

                            // Send reset link
                            AuthButton(
                              label: AppStrings.sendResetLink,
                              isPrimary: false,
                              icon: Icons.arrow_forward,
                              onPressed: () => context
                                  .read<AuthCubit>()
                                  .submitForgotPassword(
                                    email: _emailController.text,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05), // 40

                // Divider
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 600),
                  child: Divider(
                    color: AppColors.ghostBorder.withValues(alpha: 0.1),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                // Return to Login
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  duration: const Duration(milliseconds: 600),
                  child: GestureDetector(
                    onTap: () => context.read<AuthCubit>().showLogin(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: AppColors.silver.withValues(alpha: 0.5),
                          size: 14,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.returnToLogin,
                          style: GoogleFonts.inter(
                            color: AppColors.silver.withValues(alpha: 0.5),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01), // 8

                // Contact Support
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 600),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      AppStrings.contactSupport,
                      style: GoogleFonts.inter(
                        color: AppColors.accentGold,
                        fontSize: 14 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1), // 80

                // Decorative footer
                FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(milliseconds: 600),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AppStrings.logoPath,
                        width: 22,
                        colorFilter: const ColorFilter.mode(
                          AppColors.silver,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.015), // 12
                      Text(
                        'SECURITY PROTOCOL V4.0',
                        style: GoogleFonts.inter(
                          color: AppColors.silver.withValues(alpha: 0.3),
                          fontSize: 10 * SizeConfig.textMultiplier,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06), // 48
              ],
            ),
          ),
          ),
        ),
      ),
    ),
    );
  }
}
