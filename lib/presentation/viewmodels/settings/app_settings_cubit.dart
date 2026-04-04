import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit() : super(const AppSettingsState());

  void toggleDarkMode(bool value) => emit(state.copyWith(isDarkMode: value));
  void togglePushNotifications(bool value) => emit(state.copyWith(pushNotifications: value));
  void toggleBiometrics(bool value) => emit(state.copyWith(useBiometrics: value));
  
  void setSummaryLength(int length) => emit(state.copyWith(summaryLength: length));
}
