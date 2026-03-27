import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../logic/auth_cubit.dart';
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError &&
            state.previousState is ResetPasswordState) {
          setState(() => _errorMessage = state.message);
        } else {
          setState(() => _errorMessage = null);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldDark,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 48),

                // Brand
                Text(
                  AppStrings.brandName,
                  style: GoogleFonts.newsreader(
                    color: AppColors.silver,
                    fontSize: 56,
                    fontStyle: FontStyle.italic,
                    letterSpacing: -2.8,
                  ),
                ),
                const SizedBox(height: 16),

                // Subtitle with italic emphasis
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.newsreader(
                      color: AppColors.silver.withValues(alpha: 0.6),
                      fontSize: 18,
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
                const SizedBox(height: 24),

                // ── Security Update badge ──
                Align(
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
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // ── Card ──
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
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
                          fontSize: 30,
                          letterSpacing: -0.75,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppStrings.resetSubtitle,
                        style: GoogleFonts.inter(
                          color: AppColors.silver.withValues(alpha: 0.8),
                          fontSize: 14,
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
                const SizedBox(height: 32),

                // Confirm button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AuthButton(
                    label: AppStrings.confirmNewPassword,
                    isPrimary: true,
                    icon: Icons.arrow_forward,
                    onPressed: () =>
                        context.read<AuthCubit>().submitResetPassword(
                              password: _passwordController.text,
                              confirmPassword: _confirmController.text,
                            ),
                  ),
                ),
                const SizedBox(height: 32),

                // Return to portal
                GestureDetector(
                  onTap: () => context.read<AuthCubit>().showLogin(),
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
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 64),

                // Obsidian Protocol
                Text(
                  'Obsidian Protocol v2.4',
                  style: GoogleFonts.newsreader(
                    color: AppColors.silver.withValues(alpha: 0.25),
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
