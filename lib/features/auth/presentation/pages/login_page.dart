import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../widgets/social_auth_row.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show OAuthProvider;

/// Login screen (Figma Node 17-22).
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure && state.previousState is Unauthenticated) {
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
        } else if (state is AuthLoading) {
          // Handled by builder
        } else {
          setState(() => _errorMessage = null);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading && state.previousState is Unauthenticated;
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
          body: Stack(
          children: [
            // ── Background blurs ──
            Positioned(
              top: -104,
              left: -39,
              child: _blur(
                width: 156,
                height: 414,
                color: AppColors.navyButton.withValues(alpha: 0.2),
              ),
            ),
            Positioned(
              bottom: -52,
              right: -20,
              child: _blur(
                width: 117,
                height: 311,
                color: const Color(0xFF3B2400).withValues(alpha: 0.2),
              ),
            ),

            // ── Content ──
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 32

                    // Logo anchor
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: Hero(
                        tag: 'logo_anchor',
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.inputFillDark,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.ghostBorder.withValues(alpha: 0.15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.4),
                                blurRadius: 80,
                                offset: const Offset(0, 20),
                              ),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              AppStrings.logoPath,
                              width: 26,
                              height: 29,
                              colorFilter: const ColorFilter.mode(
                                AppColors.silver,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                    // Title
                    FadeInUp(
                      delay: const Duration(milliseconds: 100),
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        AppStrings.brandName,
                        style: GoogleFonts.newsreader(
                          color: AppColors.textPrimary,
                          fontSize: 48 * SizeConfig.textMultiplier,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -2.4,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.015), // 12

                    // Subtitle
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        AppStrings.obsidianCurator.toUpperCase(),
                        style: GoogleFonts.inter(
                          color: AppColors.silver.withValues(alpha: 0.6),
                          fontSize: 14 * SizeConfig.textMultiplier,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.06), // 48

                    // ── Login Card ──
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 600),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        width: double.infinity,
                      padding: const EdgeInsets.all(33),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.ghostBorder.withValues(alpha: 0.05),
                        ),
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
                          // Card heading
                          Text(
                            AppStrings.welcomeBack,
                            style: GoogleFonts.newsreader(
                              color: AppColors.textPrimary,
                              fontSize: 30 * SizeConfig.textMultiplier,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.01), // 8
                          Text(
                            AppStrings.loginSubtitle,
                            style: GoogleFonts.inter(
                              color: AppColors.silver.withValues(alpha: 0.8),
                              fontSize: 14 * SizeConfig.textMultiplier,
                              height: 1.43,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.05), // 40

                          // Email field
                          AuthTextField(
                            label: AppStrings.emailLabel,
                            hint: AppStrings.emailHint,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            errorText:
                                _errorMessage != null &&
                                    _errorMessage!.toLowerCase().contains(
                                      'email',
                                    )
                                ? _errorMessage
                                : null,
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                          // Password label + Forgot
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.passwordLabel,
                                style: GoogleFonts.inter(
                                  color: AppColors.labelBlue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context
                                    .read<AuthBloc>()
                                    .add(const ShowForgotPasswordEvent()),
                                child: Text(
                                  AppStrings.forgotPassword,
                                  style: GoogleFonts.inter(
                                    color: AppColors.iceWhite,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.01), // 8

                          // Password input (custom inline – skip label)
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.inputFill,
                              borderRadius: BorderRadius.circular(9999),
                              border: Border.all(
                                color: AppColors.inputBorderBlue.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: GoogleFonts.inter(
                                color: AppColors.textPrimary,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                hintText: AppStrings.passwordHint,
                                hintStyle: GoogleFonts.inter(
                                  color: AppColors.hintText.withValues(
                                    alpha: 0.4,
                                  ),
                                  fontSize: 16,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 19,
                                ),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColors.hintText.withValues(
                                      alpha: 0.6,
                                    ),
                                    size: 18,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                          // Login button
                          AuthButton(
                            label: AppStrings.loginButton,
                            isLoading: isLoading,
                            onPressed: isLoading
                                ? null
                                : () => context.read<AuthBloc>().add(
                                      LoginSubmitted(
                                        _emailController.text,
                                        _passwordController.text,
                                      ),
                                    ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.05), // 40

                          // Divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColors.ghostBorder.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  AppStrings.orContinueWith.toUpperCase(),
                                  style: GoogleFonts.inter(
                                    color: AppColors.hintText.withValues(
                                      alpha: 0.4,
                                    ),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColors.ghostBorder.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                          // Social Auth Row
                          SocialAuthRow(
                            onApplePressed: () =>
                                context.read<AuthBloc>().add(const SocialSignInPressed(OAuthProvider.apple)),
                            onGooglePressed: () =>
                                context.read<AuthBloc>().add(const SocialSignInPressed(OAuthProvider.google)),
                            onFacebookPressed: () =>
                                context.read<AuthBloc>().add(const SocialSignInPressed(OAuthProvider.facebook)),
                          ),
                        ],
                      ),
                    ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 32

                    // Footer
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 600),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.newHere,
                          style: GoogleFonts.inter(
                            color: AppColors.silver.withValues(alpha: 0.6),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context
                              .read<AuthBloc>()
                              .add(const ShowSignUpEvent()),
                          child: Text(
                            AppStrings.createAccount,
                            style: GoogleFonts.inter(
                              color: AppColors.labelBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
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
          ],
        ),
      );
    },
  );
}

  Widget _blur({
    required double width,
    required double height,
    required Color color,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
