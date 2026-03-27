import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add import
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth_bloc.dart';
import '../../logic/auth_state.dart';
import 'auth_success_page.dart';
import 'forgot_password_page.dart';
import 'login_page.dart';
import 'otp_verification_page.dart';
import 'reset_password_page.dart';
import 'sign_up_page.dart';

/// Top-level auth flow controller.
///
/// Listen to [AuthBloc] and renders the correct page based on state.
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Navigate to Home Page
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (state is AuthOnboarding) {
          // Exit the app as requested (Login -> Back -> Close App)
          SystemNavigator.pop();
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
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
      AuthInitial() || Unauthenticated() => const LoginPage(key: ValueKey('login')),
      Registering() => const SignUpPage(key: ValueKey('signup')),
      OTPVerification() => const OtpVerificationPage(key: ValueKey('otp')),
      ForgotPasswordState() => const ForgotPasswordPage(key: ValueKey('forgot')),
      ResetPasswordState() => const ResetPasswordPage(key: ValueKey('reset')),
      AuthSuccess() => const AuthSuccessPage(key: ValueKey('success')),
      AuthOnboarding() => const SizedBox.shrink(), // Transition state handled by listener
      AuthLoading(previousState: final prev) => _pageForState(prev),
      AuthFailure(previousState: final prev) => _pageForState(prev),
      Authenticated() => const SizedBox.shrink(),
    };
  }
}

