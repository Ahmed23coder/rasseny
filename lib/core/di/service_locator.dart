import 'package:get_it/get_it.dart';

import '../../../features/auth/logic/auth_cubit.dart';
import '../../../features/onboarding/logic/onboarding_cubit.dart';
import '../../../features/onboarding/logic/splash_cubit.dart';

final GetIt sl = GetIt.instance;

/// Initializes all service-locator registrations.
void initServiceLocator() {
  // ── Cubits ──
  sl.registerFactory<SplashCubit>(() => SplashCubit());
  sl.registerFactory<OnboardingCubit>(() => OnboardingCubit());
  sl.registerFactory<AuthCubit>(() => AuthCubit());
}
