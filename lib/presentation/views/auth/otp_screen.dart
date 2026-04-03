import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/typography/app_text_styles.dart';
import '../../../core/utils/responsive_util.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../viewmodels/auth/otp_cubit.dart';
import '../../viewmodels/auth/otp_state.dart';
import '../../widgets/auth/auth_icon_header.dart';
import '../../widgets/auth/otp_input_field.dart';
import '../../widgets/buttons/error_button.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../../core/navigation/app_router.dart';

class OtpScreen extends StatelessWidget {
  final bool isFromSignup;
  const OtpScreen({super.key, this.isFromSignup = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(context.read<AuthRepository>()),
      child: _OtpView(isFromSignup: isFromSignup),
    );
  }
}

class _OtpView extends StatelessWidget {
  final bool isFromSignup;
  const _OtpView({required this.isFromSignup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state.status == OtpStatus.success) {
            if (isFromSignup) {
              context.go(AppRouter.interests);
            } else {
              context.go(AppRouter.resetPassword);
            }
          } else if (state.status == OtpStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Invalid code")),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<OtpCubit>();

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(24)),
              child: Column(
                children: [
                  SizedBox(height: context.scaleHeight(16)),
                  const AuthIconHeader(
                    icon: Icons.verified_user_outlined,
                    title: "Check your email",
                    description:
                        "We've sent a 4-digit verification code to your email address.",
                  ),
                  SizedBox(height: context.scaleHeight(48)),
                  OtpInputField(
                    onCompleted: cubit.updateCode,
                    hasError: state.status == OtpStatus.error,
                  ),
                  if (state.status == OtpStatus.error) ...[
                    SizedBox(height: context.scaleHeight(12)),
                    Text(
                      state.errorMessage ?? "Invalid verification code",
                      style: AppTextStyles.error(context),
                    ),
                  ],
                  SizedBox(height: context.scaleHeight(32)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Resend code in ",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: context.scaleFontSize(14),
                          color: AppColors.silverSecondaryLabel,
                        ),
                      ),
                      Text(
                        state.formattedTime,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: context.scaleFontSize(14),
                          color: AppColors.foreground,
                        ),
                      ),
                    ],
                  ),
                  if (state.canResend) ...[
                    TextButton(
                      onPressed: cubit.resend,
                      child: const Text("Resend Now", style: TextStyle(color: AppColors.primaryAccent)),
                    ),
                  ],
                  SizedBox(height: context.scaleHeight(32)),
                  if (state.status == OtpStatus.error) ...[
                    ErrorButton(
                      label: "Try Again",
                      onPressed: cubit.verify,
                    ),
                  ] else ...[
                    PrimaryButton(
                      label: "Verify",
                      isLoading: state.status == OtpStatus.loading,
                      isDisabled: !state.isComplete,
                      onPressed: cubit.verify,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
