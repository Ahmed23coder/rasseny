import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/navigation/app_router.dart';
import '../../../core/utils/responsive_util.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../viewmodels/auth/forgot_password_cubit.dart';
import '../../viewmodels/auth/forgot_password_state.dart';
import '../../widgets/auth/auth_footer_link.dart';
import '../../widgets/auth/auth_icon_header.dart';
import '../../widgets/buttons/error_button.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/app_text_input.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(context.read<AuthRepository>()),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatelessWidget {
  const _ForgotPasswordView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status == ForgotPasswordStatus.success) {
            context.go(AppRouter.otp, extra: false);
          } else if (state.status == ForgotPasswordStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Error occurred")),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ForgotPasswordCubit>();

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(24)),
              child: Column(
                children: [
                  SizedBox(height: context.scaleHeight(16)),
                  const AuthIconHeader(
                    icon: Icons.email_outlined,
                    title: "Forgot Password",
                    description:
                        "Enter your email address and we'll send you a recovery link.",
                  ),
                  SizedBox(height: context.scaleHeight(40)),
                  AppTextInput(
                    hintText: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: cubit.updateEmail,
                    errorText: state.emailError,
                  ),
                  SizedBox(height: context.scaleHeight(32)),
                  if (state.status == ForgotPasswordStatus.error) ...[
                    ErrorButton(
                      label: state.errorMessage ?? "Error occurred",
                      onPressed: cubit.sendCode,
                    ),
                  ] else ...[
                    PrimaryButton(
                      label: "Send Code",
                      isLoading: state.status == ForgotPasswordStatus.loading,
                      isDisabled: !state.isFormValid,
                      onPressed: cubit.sendCode,
                    ),
                  ],
                  SizedBox(height: context.scaleHeight(40)),
                  AuthFooterLink(
                    caption: "Remember your password?",
                    actionText: "Login",
                    onTap: () => context.go(AppRouter.login),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
