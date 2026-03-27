import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'splash_state.dart';

/// Manages the splash screen lifecycle.
///
/// Checks session and first-run status to determine navigation.
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._supabaseClient, this._prefs) : super(const SplashInitial());

  final SupabaseClient _supabaseClient;
  final SharedPreferences _prefs;

  static const String _firstRunKey = 'is_first_run';

  Future<void> startSplash() async {
    emit(const SplashLoading());
    
    // Minimum splash duration for animation branding
    await Future.delayed(const Duration(seconds: 4));

    final isFirstRun = _prefs.getBool(_firstRunKey) ?? true;
    
    if (isFirstRun) {
      emit(const NavigateToOnboarding());
    } else {
      final session = _supabaseClient.auth.currentSession;
      if (session != null) {
        emit(const NavigateToHome());
      } else {
        emit(const NavigateToAuth());
      }
    }
  }

  Future<void> markOnboardingFinished() async {
    await _prefs.setBool(_firstRunKey, false);
  }
}
