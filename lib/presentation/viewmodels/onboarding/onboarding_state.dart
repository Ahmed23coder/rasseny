import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentPage;
  
  const OnboardingState({
    required this.currentPage,
  });

  factory OnboardingState.initial() {
    return const OnboardingState(currentPage: 0);
  }

  bool get isLastPage => currentPage == 2;

  OnboardingState copyWith({
    int? currentPage,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [currentPage];
}
