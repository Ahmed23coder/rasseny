import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/logic/auth_bloc.dart';
import '../../../features/onboarding/logic/onboarding_cubit.dart';
import '../../../features/onboarding/logic/splash_cubit.dart';

final GetIt sl = GetIt.instance;

/// Initializes all service-locator registrations.
Future<void> initServiceLocator() async {
  // ── Services ──
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // ── Cubits & Blocs ──
  sl.registerLazySingleton<SplashCubit>(() => SplashCubit(sl<SupabaseClient>(), sl<SharedPreferences>()));
  sl.registerFactory<OnboardingCubit>(() => OnboardingCubit());
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl<SupabaseClient>()));
}
