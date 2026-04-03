import 'package:go_router/go_router.dart';

import '../../presentation/shell/app_shell.dart';
import '../../presentation/views/splash/splash_screen.dart';
import '../../presentation/views/stub_screen.dart';
import '../../presentation/views/onboarding/onboarding_screen.dart';

/// Declarative navigation with [GoRouter].
///
/// The main shell uses an [AppShell] with bottom navigation.
/// Feature routes are defined with named constants for type-safe navigation.
class AppRouter {
  AppRouter._();

  // ── Route names ────────────────────────────────────────────────
  static const String splash = '/splash';
  static const String shell = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';
  static const String resetPassword = '/reset-password';
  static const String interests = '/interests';
  static const String onboarding = '/onboarding';
  static const String articleDetail = '/article/:id';
  static const String summarize = '/summarize/:id';
  static const String factCheck = '/fact-check/:id';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String editProfile = '/edit-profile';
  static const String language = '/language';
  static const String appSettings = '/app-settings';
  static const String subscription = '/subscription';
  static const String readingHistory = '/reading-history';
  static const String savedArticles = '/saved-articles';
  static const String about = '/about';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      // ── Entry ────────────────────────────────────────────────
      GoRoute(path: splash, builder: (_, __) => const SplashScreen()),

      // ── Main shell with bottom nav ───────────────────────────
      GoRoute(path: shell, builder: (_, __) => const AppShell()),

      // ── Auth flow ────────────────────────────────────────────
      GoRoute(
        path: login,
        builder: (_, __) => const StubScreen(title: 'Login'),
      ),
      GoRoute(
        path: register,
        builder: (_, __) => const StubScreen(title: 'Register'),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (_, __) => const StubScreen(title: 'Forgot Password'),
      ),
      GoRoute(
        path: otp,
        builder: (_, __) => const StubScreen(title: 'OTP'),
      ),
      GoRoute(
        path: resetPassword,
        builder: (_, __) => const StubScreen(title: 'Reset Password'),
      ),
      GoRoute(
        path: interests,
        builder: (_, __) => const StubScreen(title: 'Interests'),
      ),
      GoRoute(
        path: onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),

      // ── Feature pages ────────────────────────────────────────
      GoRoute(
        path: articleDetail,
        builder: (_, state) =>
            StubScreen(title: 'Article ${state.pathParameters['id']}'),
      ),
      GoRoute(
        path: summarize,
        builder: (_, state) =>
            StubScreen(title: 'Summarize ${state.pathParameters['id']}'),
      ),
      GoRoute(
        path: factCheck,
        builder: (_, state) =>
            StubScreen(title: 'Fact Check ${state.pathParameters['id']}'),
      ),
      GoRoute(
        path: notifications,
        builder: (_, __) => const StubScreen(title: 'Notifications'),
      ),

      // ── Profile / Settings ───────────────────────────────────
      GoRoute(
        path: settings,
        builder: (_, __) => const StubScreen(title: 'Settings'),
      ),
      GoRoute(
        path: editProfile,
        builder: (_, __) => const StubScreen(title: 'Edit Profile'),
      ),
      GoRoute(
        path: language,
        builder: (_, __) => const StubScreen(title: 'Language'),
      ),
      GoRoute(
        path: appSettings,
        builder: (_, __) => const StubScreen(title: 'App Settings'),
      ),
      GoRoute(
        path: subscription,
        builder: (_, __) => const StubScreen(title: 'Subscription'),
      ),
      GoRoute(
        path: readingHistory,
        builder: (_, __) => const StubScreen(title: 'Reading History'),
      ),
      GoRoute(
        path: savedArticles,
        builder: (_, __) => const StubScreen(title: 'Saved Articles'),
      ),
      GoRoute(
        path: about,
        builder: (_, __) => const StubScreen(title: 'About'),
      ),
    ],
  );
}
