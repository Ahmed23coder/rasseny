import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/navigation/app_router.dart';
import '../../../core/utils/responsive_util.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../viewmodels/auth/login_cubit.dart';
import '../../viewmodels/auth/login_state.dart';
import '../../widgets/auth/auth_divider.dart';
import '../../widgets/auth/auth_footer_link.dart';
import '../../widgets/auth/auth_header.dart';
import '../../widgets/auth/social_auth_buttons.dart';
import '../../widgets/buttons/error_button.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/app_text_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthRepository>()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            context.go(AppRouter.interests); // Or home if already set
          } else if (state.status == LoginStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Login failed")),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(24)),
              child: Column(
                children: [
                  SizedBox(height: context.scaleHeight(40)),
                  const AuthHeader(
                    title: "Welcome Back",
                    subtitle: "Sign in to your account",
                  ),
                  SizedBox(height: context.scaleHeight(40)),
                  AppTextInput(
                    hintText: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: cubit.updateEmail,
                    errorText: state.emailError,
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  AppTextInput(
                    hintText: "Password",
                    obscureText: !state.isPasswordVisible,
                    showPasswordToggle: true,
                    onChanged: cubit.updatePassword,
                    errorText: state.passwordError,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.push(AppRouter.forgotPassword),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: context.scaleFontSize(12),
                          color: AppColors.silverPlaceholder,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(12)),
                  if (state.status == LoginStatus.error) ...[
                    ErrorButton(
                      label: state.errorMessage ?? "Login Failed",
                      onPressed: cubit.submit,
                    ),
                  ] else ...[
                    PrimaryButton(
                      label: "Sign In",
                      isLoading: state.status == LoginStatus.loading,
                      isDisabled: !state.isFormValid,
                      onPressed: cubit.submit,
                    ),
                  ],
                  SizedBox(height: context.scaleHeight(32)),
                  const AuthDivider(text: "Or sign in with"),
                  SizedBox(height: context.scaleHeight(24)),
                  const SocialAuthButtons(),
                  SizedBox(height: context.scaleHeight(32)),
                  AuthFooterLink(
                    caption: "Don't have an account?",
                    actionText: "Sign Up",
                    onTap: () => context.push(AppRouter.signup),
                  ),
                  SizedBox(height: context.scaleHeight(24)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
