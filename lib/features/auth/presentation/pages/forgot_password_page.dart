import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 64),

                // Rasseny brand
                Text(
                  AppStrings.brandName,
                  style: GoogleFonts.newsreader(
                    color: AppColors.silver.withValues(alpha: 0.7),
                    fontSize: 40,
                    fontStyle: FontStyle.italic,
                    letterSpacing: -2,
                  ),
                ),
                const SizedBox(height: 32),

                // ── Main card ──
                Container(
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
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.7,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Subtitle
                            Text(
                              AppStrings.forgotSubtitle,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.newsreader(
                                color: AppColors.silver.withValues(alpha: 0.6),
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Email field
                            AuthTextField(
                              label: AppStrings.registryEmail,
                              hint: AppStrings.emailPlaceholder,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              errorText: _errorMessage,
                            ),
                            const SizedBox(height: 32),

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
                const SizedBox(height: 40),

                // Divider
                Divider(
                  color: AppColors.ghostBorder.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 24),

                // Return to Login
                GestureDetector(
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
                const SizedBox(height: 8),

                // Contact Support
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    AppStrings.contactSupport,
                    style: GoogleFonts.inter(
                      color: AppColors.accentGold,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 80),

                // Decorative footer
                Column(
                  children: [
                    SvgPicture.asset(
                      AppStrings.logoPath,
                      width: 22,
                      colorFilter: const ColorFilter.mode(
                        AppColors.silver,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'SECURITY PROTOCOL V4.0',
                      style: GoogleFonts.inter(
                        color: AppColors.silver.withValues(alpha: 0.3),
                        fontSize: 10,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
