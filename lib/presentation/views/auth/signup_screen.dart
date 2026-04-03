import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/navigation/app_router.dart';
import '../../../core/utils/responsive_util.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../viewmodels/auth/signup_cubit.dart';
import '../../viewmodels/auth/signup_state.dart';
import '../../widgets/auth/auth_back_button.dart';
import '../../widgets/auth/auth_divider.dart';
import '../../widgets/auth/auth_footer_link.dart';
import '../../widgets/auth/auth_header.dart';
import '../../widgets/auth/country_dropdown.dart';
import '../../widgets/auth/gender_selector.dart';
import '../../widgets/auth/social_auth_buttons.dart';
import '../../widgets/buttons/error_button.dart';
import '../../widgets/buttons/primary_button.dart';
import 'package:intl_phone_field_v2/intl_phone_field.dart';
import '../../widgets/auth/password_strength_indicator.dart';
import '../../widgets/inputs/app_text_input.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(context.read<AuthRepository>()),
      child: const _SignupView(),
    );
  }
}

class _SignupView extends StatelessWidget {
  const _SignupView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.status == SignupStatus.success) {
            context.go(AppRouter.otp, extra: true);
          } else if (state.status == SignupStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Sign up failed")),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignupCubit>();

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.scaleHeight(16)),
                  const AuthBackButton(),
                  SizedBox(height: context.scaleHeight(16)),
                  const Center(
                    child: AuthHeader(
                      title: "Create Account",
                      subtitle: "Join Rasseny Intelligence",
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(32)),
                  AppTextInput(
                    hintText: "Full Name",
                    onChanged: cubit.updateFullName,
                    errorText: state.fullNameError,
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  AppTextInput(
                    hintText: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: cubit.updateEmail,
                    errorText: state.emailError,
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: context.scaleFontSize(14),
                        color: AppColors.silverPlaceholder,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: AppColors.silverBorder, width: 1.185),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: AppColors.silverBorder, width: 1.185),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: AppColors.primaryAccent, width: 1.185),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: AppColors.destructive, width: 1.185),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: AppColors.destructive, width: 1.5),
                      ),
                      counterText: "", // Removes the 0/10 counter
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.scaleWidth(20),
                        vertical: context.scaleHeight(18),
                      ),
                    ),
                    initialCountryCode: 'US',
                    dropdownTextStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: context.scaleFontSize(14),
                      color: AppColors.foreground,
                    ),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: context.scaleFontSize(14),
                      color: AppColors.foreground,
                    ),
                    onChanged: (phone) => cubit.updatePhone(phone.completeNumber),
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  CountryDropdown(
                    selectedCountry: state.country,
                    onSelected: cubit.updateCountry,
                  ),
                  SizedBox(height: context.scaleHeight(24)),
                  GenderSelector(
                    selectedGender: state.gender,
                    onSelected: cubit.updateGender,
                  ),
                  SizedBox(height: context.scaleHeight(24)),
                  AppTextInput(
                    hintText: "Password",
                    obscureText: !state.isPasswordVisible,
                    showPasswordToggle: true,
                    onChanged: cubit.updatePassword,
                    errorText: state.passwordError,
                  ),
                  if (state.password.isNotEmpty) ...[
                    SizedBox(height: context.scaleHeight(12)),
                    PasswordStrengthIndicator(strength: state.passwordStrength),
                  ],
                  SizedBox(height: context.scaleHeight(16)),
                  AppTextInput(
                    hintText: "Confirm Password",
                    obscureText: !state.isPasswordVisible,
                    showPasswordToggle: true,
                    onChanged: cubit.updateConfirmPassword,
                    errorText: state.confirmPasswordError,
                  ),
                  SizedBox(height: context.scaleHeight(32)),
                  if (state.status == SignupStatus.error) ...[
                    ErrorButton(
                      label: state.errorMessage ?? "Sign up Failed",
                      onPressed: cubit.submit,
                    ),
                  ] else ...[
                    PrimaryButton(
                      label: "Create Account",
                      isLoading: state.status == SignupStatus.loading,
                      isDisabled: !state.isFormValid,
                      onPressed: cubit.submit,
                    ),
                  ],
                  SizedBox(height: context.scaleHeight(32)),
                  const AuthDivider(text: "Or sign up with"),
                  SizedBox(height: context.scaleHeight(24)),
                  const SocialAuthButtons(isSignUp: true),
                  SizedBox(height: context.scaleHeight(24)),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: context.scaleFontSize(11),
                            color: AppColors.silverSecondaryLabel,
                            height: 1.4,
                          ),
                          children: [
                            const TextSpan(text: "By creating an account you agree to our "),
                            TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(color: AppColors.foreground, fontWeight: FontWeight.w600),
                            ),
                            const TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(color: AppColors.foreground, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(32)),
                  AuthFooterLink(
                    caption: "Already have an account?",
                    actionText: "Sign In",
                    onTap: () => context.go(AppRouter.login),
                  ),
                  SizedBox(height: context.scaleHeight(40)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
