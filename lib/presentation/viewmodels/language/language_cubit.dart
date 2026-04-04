import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState());

  static const List<Map<String, String>> supportedLanguages = [
    {'name': 'English', 'code': 'en', 'native': 'English'},
    {'name': 'Arabic', 'code': 'ar', 'native': 'العربية'},
    {'name': 'French', 'code': 'fr', 'native': 'Français'},
    {'name': 'German', 'code': 'de', 'native': 'Deutsch'},
    {'name': 'Spanish', 'code': 'es', 'native': 'Español'},
  ];

  void selectLanguage(String code) {
    emit(state.copyWith(selectedCode: code));
  }
}
