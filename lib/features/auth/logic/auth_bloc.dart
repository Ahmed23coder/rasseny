import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SupabaseClient _supabaseClient;
  Timer? _otpTimer;

  AuthBloc(this._supabaseClient) : super(const AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<VerifyOTPSubmitted>(_onVerifyOTPSubmitted);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<ResetPasswordSubmitted>(_onResetPasswordSubmitted);
    on<SuccessGetStartedPressed>(_onSuccessGetStartedPressed);
    on<SocialSignInPressed>(_onSocialSignInPressed);
    on<LogoutRequested>(_onLogoutRequested);
    on<ShowLoginEvent>((event, emit) => emit(const Unauthenticated()));
    on<ShowSignUpEvent>((event, emit) => emit(const Registering()));
    on<ShowForgotPasswordEvent>((event, emit) => emit(const ForgotPasswordState()));
    on<ShowResetPasswordEvent>((event, emit) => emit(ResetPasswordState(email: event.email)));
    on<OtpTick>(_onOtpTick);
    on<AuthGoBack>(_onAuthGoBack);
    on<ResendOtpRequested>(_onResendOtpRequested);
  }

  void _onAuthGoBack(AuthGoBack event, Emitter<AuthState> emit) {
    if (state is OTPVerification) {
      final currentState = state as OTPVerification;
      if (currentState.isForgotFlow) {
        emit(const ForgotPasswordState());
      } else {
        emit(const Registering());
      }
    } else if (state is ForgotPasswordState || state is Registering) {
      emit(const Unauthenticated());
    } else if (state is ResetPasswordState) {
      emit(const ForgotPasswordState());
    } else if (state is Unauthenticated || state is AuthInitial) {
      emit(const AuthOnboarding());
    }
  }

  void _onSuccessGetStartedPressed(SuccessGetStartedPressed event, Emitter<AuthState> emit) {
    final user = _supabaseClient.auth.currentUser;
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(const Unauthenticated());
    }
  }

  void _onOtpTick(OtpTick event, Emitter<AuthState> emit) {
    if (state is OTPVerification) {
      final currentState = state as OTPVerification;
      emit(OTPVerification(
        email: currentState.email,
        remainingSeconds: event.remainingSeconds,
        isForgotFlow: currentState.isForgotFlow,
      ));
    }
  }

  Future<void> _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final session = _supabaseClient.auth.currentSession;
    if (session != null) {
      emit(Authenticated(session.user));
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit) async {
    final prevState = state;
    emit(AuthLoading(prevState));
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );
      if (response.user != null) {
        emit(Authenticated(response.user!));
      } else {
        emit(AuthFailure('Invalid login details', prevState));
      }
    } on AuthException catch (e) {
      emit(AuthFailure(e.message, prevState));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred', prevState));
    }
  }

  Future<void> _onSignUpSubmitted(SignUpSubmitted event, Emitter<AuthState> emit) async {
    final prevState = state;
    emit(AuthLoading(prevState));
    try {
      await _supabaseClient.auth.signUp(
        email: event.email,
        password: event.password,
        data: {'full_name': event.fullName},
      );
      emit(OTPVerification(email: event.email, isForgotFlow: false));
      _startOtpTimer(event.email);
    } on AuthException catch (e) {
      emit(AuthFailure(e.message, prevState));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred', prevState));
    }
  }

  Future<void> _onVerifyOTPSubmitted(VerifyOTPSubmitted event, Emitter<AuthState> emit) async {
    final prevState = state;
    if (prevState is! OTPVerification) return;

    emit(AuthLoading(prevState));
    try {
      final response = await _supabaseClient.auth.verifyOTP(
        email: event.email,
        token: event.token,
        type: prevState.isForgotFlow ? OtpType.recovery : OtpType.signup,
      );
      if (response.user != null) {
        _otpTimer?.cancel();
        emit(Authenticated(response.user!));
      } else {
        emit(AuthFailure('Invalid OTP', prevState));
      }
    } on AuthException catch (e) {
      emit(AuthFailure(e.message, prevState));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred', prevState));
    }
  }

  Future<void> _onForgotPasswordRequested(ForgotPasswordRequested event, Emitter<AuthState> emit) async {
    final prevState = state;
    emit(AuthLoading(prevState));
    try {
      await _supabaseClient.auth.resetPasswordForEmail(event.email);
      emit(OTPVerification(email: event.email, isForgotFlow: true));
      _startOtpTimer(event.email);
    } on AuthException catch (e) {
      emit(AuthFailure(e.message, prevState));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred', prevState));
    }
  }

  Future<void> _onResendOtpRequested(ResendOtpRequested event, Emitter<AuthState> emit) async {
    final prevState = state;
    if (prevState is! OTPVerification) return;

    emit(AuthLoading(prevState));
    try {
      await _supabaseClient.auth.resend(
        email: event.email,
        type: prevState.isForgotFlow ? OtpType.recovery : OtpType.signup,
      );
      emit(OTPVerification(
        email: event.email,
        isForgotFlow: prevState.isForgotFlow,
        remainingSeconds: 60,
      ));
      _startOtpTimer(event.email);
    } on AuthException catch (e) {
      emit(AuthFailure(e.message, prevState));
    } catch (e) {
      emit(AuthFailure('Resend failed', prevState));
    }
  }

  Future<void> _onResetPasswordSubmitted(ResetPasswordSubmitted event, Emitter<AuthState> emit) async {
    final prevState = state;
    emit(AuthLoading(prevState));
    try {
      await _supabaseClient.auth.updateUser(
        UserAttributes(password: event.password),
      );
      emit(const AuthSuccess());
    } on AuthException catch (e) {
      emit(AuthFailure(e.message, prevState));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred', prevState));
    }
  }

  Future<void> _onSocialSignInPressed(SocialSignInPressed event, Emitter<AuthState> emit) async {
    try {
      await _supabaseClient.auth.signInWithOAuth(event.provider);
    } on AuthException catch (e) {
      emit(AuthFailure(e.message, state));
    } catch (e) {
      emit(AuthFailure('Social sign in failed', state));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    await _supabaseClient.auth.signOut();
    emit(const Unauthenticated());
  }

  void _startOtpTimer(String email) {
    _otpTimer?.cancel();
    int remaining = 60;
    add(OtpTick(remaining));

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remaining--;
      if (remaining >= 0) {
        add(OtpTick(remaining));
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _otpTimer?.cancel();
    return super.close();
  }
}
