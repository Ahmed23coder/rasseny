part of 'app_settings_cubit.dart';

class AppSettingsState extends Equatable {
  final bool isDarkMode;
  final bool pushNotifications;
  final bool useBiometrics;
  final int summaryLength;

  const AppSettingsState({
    this.isDarkMode = true,
    this.pushNotifications = true,
    this.useBiometrics = false,
    this.summaryLength = 1, // 0: Short, 1: Medium, 2: Long
  });

  AppSettingsState copyWith({
    bool? isDarkMode,
    bool? pushNotifications,
    bool? useBiometrics,
    int? summaryLength,
  }) {
    return AppSettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      useBiometrics: useBiometrics ?? this.useBiometrics,
      summaryLength: summaryLength ?? this.summaryLength,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, pushNotifications, useBiometrics, summaryLength];
}
