import 'package:flutter/foundation.dart';

/// States emitted by [SplashBloc].
@immutable
sealed class SplashState {
  const SplashState();
}

/// Initial idle state.
final class SplashInitial extends SplashState {
  const SplashInitial();
}

/// Timer is running; splash animation is playing.
final class SplashLoading extends SplashState {
  const SplashLoading();
}

/// The splash timer has completed – navigate to the onboarding flow.
final class NavigateToOnboarding extends SplashState {
  const NavigateToOnboarding();
}
