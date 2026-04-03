import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/navigation/app_router.dart';
import '../../../core/utils/responsive_util.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../viewmodels/auth/reset_password_cubit.dart';
import '../../viewmodels/auth/reset_password_state.dart';
import '../../widgets/buttons/error_button.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/app_text_input.dart';
import '../../widgets/auth/auth_icon_header.dart';
import '../../widgets/auth/password_strength_indicator.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(context.read<AuthRepository>()),
      child: const _ResetPasswordView(),
    );
  }
}

class _ResetPasswordView extends StatelessWidget {
  const _ResetPasswordView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<ResetPasswordCubit, ResetState>(
        listener: (context, state) {
          if (state.status == ResetStatus.success) {
            context.go(AppRouter.authSuccess);
          } else if (state.status == ResetStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Reset failed")),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ResetPasswordCubit>();

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(24)),
              child: Column(
                children: [
                  SizedBox(height: context.scaleHeight(16)),
                  const AuthIconHeader(
                    icon: Icons.lock_outline,
                    title: "Reset Password",
                    description:
                        "Enter your new password below to regain access to your account.",
                  ),
                  SizedBox(height: context.scaleHeight(40)),

                  AppTextInput(
                    labelText: "New Password",
                    hintText: "••••••••",
                    obscureText: !state.isNewPasswordVisible,
                    showPasswordToggle: true,
                    errorText: state.newPasswordError,
                    onChanged: cubit.updateNewPassword,
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  PasswordStrengthIndicator(strength: state.passwordStrength),
                  SizedBox(height: context.scaleHeight(24)),
                  AppTextInput(
                    labelText: "Confirm Password",
                    hintText: "••••••••",
                    obscureText: !state.isConfirmPasswordVisible,
                    showPasswordToggle: true,
                    errorText: state.confirmPasswordError,
                    onChanged: cubit.updateConfirmPassword,
                  ),
                  SizedBox(height: context.scaleHeight(32)),
                  if (state.status == ResetStatus.error) ...[
                    ErrorButton(
                      label: state.errorMessage ?? "Reset Failed",
                      onPressed: cubit.submit,
                    ),
                  ] else ...[
                    PrimaryButton(
                      label: "Reset Password",
                      isLoading: state.status == ResetStatus.loading,
                      isDisabled: !state.isFormValid,
                      onPressed: cubit.submit,
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
