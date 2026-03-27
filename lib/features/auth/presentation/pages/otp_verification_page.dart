import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/size_config.dart';
import '../../logic/auth_bloc.dart';
import '../../logic/auth_event.dart';
import '../../logic/auth_state.dart';
import '../widgets/auth_button.dart';

/// OTP Verification screen (Figma Node 17-332).
class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure && state.previousState is OTPVerification) {
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
        }
      },
      builder: (context, state) {
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
                    SizedBox(height: SizeConfig.screenHeight * 0.07), // 56

                    // Anchor icon
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: Hero(
                        tag: 'logo_anchor',
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.inputBorderBlue.withValues(alpha: 0.3),
                                AppColors.inputFillDark.withValues(alpha: 0.8),
                              ],
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              AppStrings.logoPath,
                              width: 26,
                              height: 29,
                              colorFilter: const ColorFilter.mode(
                                AppColors.labelBlue,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.05), // 40

                    // Title
                    FadeInUp(
                      delay: const Duration(milliseconds: 100),
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        AppStrings.secureYourAnchor,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.newsreader(
                          color: AppColors.textPrimary,
                          fontSize: 48 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -2.4,
                          height: 1.08,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                    // Subtitle
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        AppStrings.otpSubtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: AppColors.silver.withValues(alpha: 0.6),
                          fontSize: 16 * SizeConfig.textMultiplier,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.07), // 56

                    // ── OTP Boxes ──
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 600),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          return Container(
                            width: 48,
                            height: 64,
                            margin: EdgeInsets.only(right: index < 5 ? 8 : 0),
                            decoration: BoxDecoration(
                              color: AppColors.inputFillDark,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.inputBorderBlue.withValues(alpha: 0.2),
                              ),
                            ),
                            child: TextField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              style: GoogleFonts.inter(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: const InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  _focusNodes[index + 1].requestFocus();
                                }
                                if (value.isEmpty && index > 0) {
                                  _focusNodes[index - 1].requestFocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.07), // 56

                    // Verify button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;
                        return AuthButton(
                          label: AppStrings.verifyIdentity,
                          isPrimary: false,
                          isLoading: isLoading,
                          onPressed: isLoading ? null : () {
                            final state = context.read<AuthBloc>().state;
                            if (state is OTPVerification) {
                              context.read<AuthBloc>().add(VerifyOTPSubmitted(state.email, _otp));
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 32

                    // Timer
                    BlocSelector<AuthBloc, AuthState, int>(
                      selector: (state) =>
                          state is OTPVerification ? state.remainingSeconds : 0,
                      builder: (context, remaining) {
                        if (remaining == 0) {
                          return GestureDetector(
                            onTap: () {
                              final authBloc = context.read<AuthBloc>();
                              if (authBloc.state is OTPVerification) {
                                authBloc.add(ResendOtpRequested((authBloc.state as OTPVerification).email));
                              }
                            },
                            child: Text(
                              AppStrings.resendCode,
                              style: GoogleFonts.inter(
                                color: AppColors.labelBlue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.labelBlue,
                              ),
                            ),
                          );
                        }
                        
                        final mins = (remaining ~/ 60).toString().padLeft(2, '0');
                        final secs = (remaining % 60).toString().padLeft(2, '0');
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: AppColors.accentGold.withValues(alpha: 0.8),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${AppStrings.resendCodeIn}$mins:$secs',
                              style: GoogleFonts.inter(
                                color: AppColors.silver.withValues(alpha: 0.6),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03), // 24

                    // Try another way
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${AppStrings.didntReceive}  ',
                          style: GoogleFonts.inter(
                            color: AppColors.silver.withValues(alpha: 0.4),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppStrings.tryAnotherWay,
                            style: GoogleFonts.inter(
                              color: AppColors.labelBlue,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.labelBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.06), // 48
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
