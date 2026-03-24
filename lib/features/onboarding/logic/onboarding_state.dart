import 'package:flutter/foundation.dart';

/// State for the onboarding flow.
@immutable
class OnboardingState {
  const OnboardingState({this.currentPage = 0, this.totalPages = 3});

  final int currentPage;
  final int totalPages;

  bool get isLastPage => currentPage == totalPages - 1;

  OnboardingState copyWith({int? currentPage}) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages,
    );
  }
}
