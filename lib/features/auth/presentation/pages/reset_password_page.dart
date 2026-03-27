import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/size_config.dart';
import '../../logic/auth_bloc.dart';
import '../../logic/auth_event.dart';
import '../../logic/auth_state.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_strength_meter.dart';

/// Reset Password screen (Figma Node 17-223).
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String _password = '';
  String? _errorMessage;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure && state.previousState is ResetPasswordState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
          setState(() => _errorMessage = state.message);
        } else if (state is ResetPasswordState) {
          setState(() => _errorMessage = null);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading && state.previousState is ResetPasswordState;
        return Scaffold(
          backgroundColor: AppColors.scaffoldDark,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => context.read<AuthBloc>().add(const AuthGoBack()),
            ),
          ),
          body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.06), // 48
    
                    // Brand
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        AppStrings.brandName,
                        style: GoogleFonts.newsreader(
                          color: AppColors.silver,
                          fontSize: 56 * SizeConfig.textMultiplier,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -2.8,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02), // 16
    
                    // Subtitle with italic emphasis
                    FadeInUp(
                      delay: const Duration(milliseconds: 100),
                      duration: const Duration(milliseconds: 600),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.newsreader(
                            color: AppColors.silver.withValues(alpha: 0.6),
                            fontSize: 18 * SizeConfig.textMultiplier,
                          ),
                          children: [
                            const TextSpan(text: 'Secure your narrative. '),
                            TextSpan(
                              text: 'Define your\naccess.',
                              style: GoogleFonts.newsreader(
                                fontStyle: FontStyle.italic,
                                color: AppColors.silver.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                    // ── Security Update badge ──
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 600),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentGold,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            AppStrings.securityUpdate,
                            style: GoogleFonts.inter(
                              color: AppColors.accentGoldDark,
                              fontSize: 12 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01), // 8

                    // ── Card ──
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 600),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: AppColors.inputFillDark.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(48),
                          border: Border.all(
                            color: AppColors.ghostBorder.withValues(alpha: 0.06),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 80,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.setNewCredentials,
                              style: GoogleFonts.newsreader(
                                color: AppColors.textPrimary,
                                fontSize: 30 * SizeConfig.textMultiplier,
                                letterSpacing: -0.75,
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.015), // 12
                            Text(
                              AppStrings.resetSubtitle,
                              style: GoogleFonts.inter(
                                color: AppColors.silver.withValues(alpha: 0.8),
                                fontSize: 14 * SizeConfig.textMultiplier,
                                height: 1.43,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // New password
                            AuthTextField(
                              label: AppStrings.newPasswordLabel,
                              hint: AppStrings.passwordHint,
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              onToggleObscure: () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                              onChanged: (v) => setState(() => _password = v),
                              errorText: _errorMessage != null &&
                                      !_errorMessage!.toLowerCase().contains('match')
                                  ? _errorMessage
                                  : null,
                            ),
                            const SizedBox(height: 12),

                            // Password strength
                            PasswordStrengthMeter(password: _password),
                            const SizedBox(height: 8),

                            // Strength description
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'Complexity meets composition. Your password is strong.',
                                style: GoogleFonts.newsreader(
                                  color: AppColors.accentGold.withValues(alpha: 0.7),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Confirm password
                            AuthTextField(
                              label: AppStrings.confirmPasswordLabel,
                              hint: AppStrings.passwordHint,
                              controller: _confirmController,
                              obscureText: _obscureConfirm,
                              onToggleObscure: () => setState(
                                () => _obscureConfirm = !_obscureConfirm,
                              ),
                              errorText: _errorMessage != null &&
                                      _errorMessage!.toLowerCase().contains('match')
                                  ? _errorMessage
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 32

                    // Confirm button
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 600),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AuthButton(
                          label: AppStrings.confirmNewPassword,
                          isPrimary: true,
                          icon: Icons.arrow_forward,
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () => context.read<AuthBloc>().add(
                                    ResetPasswordSubmitted(
                                      password: _passwordController.text,
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 32

                    // Return to portal
                    FadeInUp(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 600),
                      child: GestureDetector(
                        onTap: () => context.read<AuthBloc>().add(const ShowLoginEvent()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: AppColors.silver.withValues(alpha: 0.4),
                              size: 14,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              AppStrings.returnToPortal,
                              style: GoogleFonts.inter(
                                color: AppColors.silver.withValues(alpha: 0.4),
                                fontSize: 12 * SizeConfig.textMultiplier,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08), // 64

                    // Obsidian Protocol
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        'Obsidian Protocol v2.4',
                        style: GoogleFonts.newsreader(
                          color: AppColors.silver.withValues(alpha: 0.25),
                          fontSize: 14 * SizeConfig.textMultiplier,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 32
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
