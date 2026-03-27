import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../logic/auth_cubit.dart';
import '../../logic/auth_state.dart';
import 'login_page.dart';
import 'sign_up_page.dart';
import 'otp_verification_page.dart';
import 'forgot_password_page.dart';
import 'reset_password_page.dart';
import 'package:shimmer/shimmer.dart';
import 'auth_success_page.dart';

/// Top-level auth flow controller.
///
/// Provides [AuthCubit] and renders the correct page based on state.
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<AuthCubit>(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _pageForState(state),
          );
        },
      ),
    );
  }

  Widget _pageForState(AuthState state) {
    return switch (state) {
      Unauthenticated() || AuthInitial() => const LoginPage(key: ValueKey('login')),
      Registering() => const SignUpPage(key: ValueKey('signup')),
      OTPVerification() => const OtpVerificationPage(key: ValueKey('otp')),
      ForgotPasswordState() => const ForgotPasswordPage(key: ValueKey('forgot')),
      ResetPasswordState() => const ResetPasswordPage(key: ValueKey('reset')),
      AuthSuccess() => const AuthSuccessPage(key: ValueKey('success')),
      AuthLoading() => const _LoadingOverlay(key: ValueKey('loading')),
      AuthError(previousState: final prev) => _pageForState(prev),
      _ => const LoginPage(key: ValueKey('login')),
    };
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldDark,
      body: Center(
        child: Shimmer.fromColors(
          baseColor: AppColors.slateBlue.withValues(alpha: 0.2),
          highlightColor: AppColors.slateBlue.withValues(alpha: 0.5),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
      ),
    );
  }
}

