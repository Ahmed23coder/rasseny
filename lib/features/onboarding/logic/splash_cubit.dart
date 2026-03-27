import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_state.dart';

/// Manages the splash screen lifecycle.
///
/// Calls [startSplash] to emit [SplashLoading], waits 2 seconds,
/// then emits [NavigateToOnboarding] to trigger navigation.
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<void> startSplash() async {
    emit(const SplashLoading());
    await Future.delayed(const Duration(seconds: 4));
    emit(const NavigateToOnboarding());
  }
}
