import 'package:go_router/go_router.dart';

import '../../presentation/shell/app_shell.dart';
import '../../presentation/views/article/article_detail_screen.dart';
import '../../presentation/views/history/reading_history_screen.dart';
import '../../presentation/views/vault/vault_screen.dart';
import '../../presentation/views/channels/channels_screen.dart';
import '../../presentation/views/language/language_screen.dart';
import '../../presentation/views/settings/app_settings_screen.dart';
import '../../presentation/views/notifications/notifications_screen.dart';
import '../../presentation/views/subscription/subscription_screen.dart';
import '../../presentation/views/about/about_screen.dart';
import '../../presentation/views/auth/auth_success_screen.dart';
import '../../presentation/views/auth/forgot_password_screen.dart';
import '../../presentation/views/auth/interests_screen.dart';
import '../../presentation/views/auth/login_screen.dart';
import '../../presentation/views/auth/otp_screen.dart';
import '../../presentation/views/auth/reset_password_screen.dart';
import '../../presentation/views/auth/signup_screen.dart';
import '../../presentation/views/onboarding/onboarding_screen.dart';
import '../../presentation/views/splash/splash_screen.dart';
import '../../presentation/views/stub_screen.dart';

/// Declarative navigation with [GoRouter].
///
/// The main shell uses an [AppShell] with bottom navigation.
/// Feature routes are defined with named constants for type-safe navigation.
class AppRouter {
  AppRouter._();

  // ── Route names ────────────────────────────────────────────────
  static const String splash = '/splash';
  static const String shell = '/';
  static const String login = '/auth';
  static const String signup = '/auth/signup';
  static const String forgotPassword = '/auth/forgot-password';
  static const String otp = '/auth/otp';
  static const String resetPassword = '/auth/reset-password';
  static const String interests = '/auth/interests';
  static const String authSuccess = '/auth/success';
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
  static const String myChannels = '/my-channels';
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
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: signup,
        builder: (_, __) => const SignupScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (_, __) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: otp,
        builder: (_, state) {
          final isFromSignup = state.extra as bool? ?? false;
          return OtpScreen(isFromSignup: isFromSignup);
        },
      ),
      GoRoute(
        path: resetPassword,
        builder: (_, __) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: interests,
        builder: (_, __) => const InterestsScreen(),
      ),
      GoRoute(
        path: authSuccess,
        builder: (_, __) => const AuthSuccessScreen(),
      ),
      GoRoute(
        path: onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),

      // ── Feature pages ────────────────────────────────────────
      GoRoute(
        path: articleDetail,
        builder: (_, state) {
          final id = state.pathParameters['id'] ?? '1';
          return ArticleDetailScreen(id: id);
        },
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
        builder: (_, __) => const NotificationsScreen(),
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
        builder: (_, __) => const LanguageScreen(),
      ),
      GoRoute(
        path: appSettings,
        builder: (_, __) => const AppSettingsScreen(),
      ),
      GoRoute(
        path: subscription,
        builder: (_, __) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: readingHistory,
        builder: (_, __) => const ReadingHistoryScreen(),
      ),
      GoRoute(
        path: savedArticles,
        builder: (_, __) => const VaultScreen(),
      ),
      GoRoute(
        path: myChannels,
        builder: (_, __) => const ChannelsScreen(),
      ),
      GoRoute(
        path: about,
        builder: (_, __) => const AboutScreen(),
      ),
    ],
  );
}
