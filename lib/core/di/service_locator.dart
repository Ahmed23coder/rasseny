import 'package:get_it/get_it.dart';

import '../../../features/onboarding/logic/onboarding_cubit.dart';
import '../../../features/splash/logic/cubit/splash_cubit.dart';

final GetIt sl = GetIt.instance;

/// Initializes all service-locator registrations.
void initServiceLocator() {
  // ── Cubits ──
  sl.registerFactory<SplashCubit>(() => SplashCubit());
  sl.registerFactory<OnboardingCubit>(() => OnboardingCubit());
}
