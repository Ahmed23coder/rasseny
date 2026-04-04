part of 'language_cubit.dart';

class LanguageState extends Equatable {
  final String selectedCode;

  const LanguageState({
    this.selectedCode = 'en',
  });

  LanguageState copyWith({
    String? selectedCode,
  }) {
    return LanguageState(
      selectedCode: selectedCode ?? this.selectedCode,
    );
  }

  @override
  List<Object?> get props => [selectedCode];
}
