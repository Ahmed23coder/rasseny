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

/// Sign-up screen (Figma Node 17-377).
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String _password = '';
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError && state.previousState is Registering) {
          setState(() => _errorMessage = state.message);
        } else {
          setState(() => _errorMessage = null);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldDark,
        body: Stack(
          children: [
            // Background blurs
            Positioned(
              top: 133,
              left: 20,
              child: Container(
                width: 156,
                height: 156,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.labelBlue.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              bottom: 133,
              right: 20,
              child: Container(
                width: 117,
                height: 117,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentGold.withValues(alpha: 0.05),
                ),
              ),
            ),

            // Content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 36,
                ),
                child: Column(
                  children: [
                    // Brand header
                    Text(
                      AppStrings.brandName,
                      style: GoogleFonts.newsreader(
                        color: AppColors.silver,
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        letterSpacing: -2.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.obsidianCurator.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: AppColors.silver.withValues(alpha: 0.6),
                        fontSize: 14,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // ── Registration Card ──
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: AppColors.cardDark,
                        borderRadius: BorderRadius.circular(48),
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
                            AppStrings.createYourAccount,
                            style: GoogleFonts.newsreader(
                              color: AppColors.textPrimary,
                              fontSize: 30,
                              letterSpacing: -0.75,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Full Name
                          AuthTextField(
                            label: AppStrings.fullNameLabel,
                            hint: AppStrings.fullNameHint,
                            controller: _nameController,
                            errorText: _errorMessage != null &&
                                    _errorMessage!.toLowerCase().contains('name')
                                ? _errorMessage
                                : null,
                          ),
                          const SizedBox(height: 24),

                          // Email
                          AuthTextField(
                            label: AppStrings.emailLabel,
                            hint: AppStrings.emailHint,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            errorText: _errorMessage != null &&
                                    _errorMessage!.toLowerCase().contains('email')
                                ? _errorMessage
                                : null,
                          ),
                          const SizedBox(height: 24),

                          // Password
                          AuthTextField(
                            label: AppStrings.passwordLabel,
                            hint: AppStrings.passwordHint,
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            onToggleObscure: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            onChanged: (v) => setState(() => _password = v),
                            errorText: _errorMessage != null &&
                                    _errorMessage!.toLowerCase().contains('password')
                                ? _errorMessage
                                : null,
                          ),
                          const SizedBox(height: 12),

                          // Password Strength Meter
                          PasswordStrengthMeter(password: _password),
                          const SizedBox(height: 24),

                          // Submit button
                          AuthButton(
                            label: AppStrings.beginJourney,
                            isPrimary: false,
                            onPressed: () =>
                                context.read<AuthCubit>().submitRegistration(
                                      fullName: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                          ),
                          const SizedBox(height: 32),

                          // Already a member
                          Center(
                            child: GestureDetector(
                              onTap: () =>
                                  context.read<AuthCubit>().showLogin(),
                              child: RichText(
                                text: TextSpan(
                                  text: AppStrings.alreadyMember,
                                  style: GoogleFonts.inter(
                                    color: AppColors.silver.withValues(alpha: 0.6),
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: AppStrings.signIn,
                                      style: GoogleFonts.inter(
                                        color: AppColors.labelBlue,
                                        fontSize: 14,
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
                    const SizedBox(height: 32),

                    // ── Why Verify Card ──
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: AppColors.navyButton,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: Stack(
                        children: [
                          // Decorative blur
                          Positioned(
                            top: -48,
                            right: -48,
                            child: Container(
                              width: 192,
                              height: 192,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.labelBlue.withValues(alpha: 0.05),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Shield icon
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.inputBorderBlue
                                      .withValues(alpha: 0.2),
                                ),
                                child: const Icon(
                                  Icons.verified_user_outlined,
                                  color: AppColors.labelBlue,
                                  size: 25,
                                ),
                              ),
                              const SizedBox(height: 24),

                              Text(
                                AppStrings.whyVerify,
                                style: GoogleFonts.newsreader(
                                  color: AppColors.textPrimary,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: -0.6,
                                ),
                              ),
                              const SizedBox(height: 12),

                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(
                                    color: AppColors.silver.withValues(alpha: 0.8),
                                    fontSize: 16,
                                    height: 1.625,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Verification is not a hurdle, but a '
                                          'foundation. We use this step to ',
                                    ),
                                    TextSpan(
                                      text: 'anchor your data security',
                                      style: GoogleFonts.inter(
                                        color: AppColors.labelBlue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' and ensure your curated collection '
                                          'remains exclusively yours.',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Footer links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _footerLink('PRIVACY'),
                        const SizedBox(width: 32),
                        _footerLink('TERMS'),
                        const SizedBox(width: 32),
                        _footerLink('SECURITY'),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _footerLink(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: AppColors.silver.withValues(alpha: 0.4),
        fontSize: 12,
        letterSpacing: 2.4,
      ),
    );
  }
}
