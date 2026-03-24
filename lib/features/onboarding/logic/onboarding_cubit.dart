import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_state.dart';

/// Data model for a single onboarding slide.
class OnboardingContent {
  const OnboardingContent({
    required this.title,
    this.titleItalicPart,
    required this.description,
    this.label,
    required this.imagePath,
  });

  final String title;
  final String? titleItalicPart;
  final String description;
  final String? label;
  final String imagePath;
}

/// Manages the onboarding page index and content.
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  /// Hardcoded onboarding content for the 3 screens.
  final List<OnboardingContent> pages = const [
    OnboardingContent(
      title: 'Global\nAuthority.',
      description:
          'Rasseny anchors you to the most reliable\nnews sources worldwide.',
      imagePath: 'assets/images/onboarding_global.png',
    ),
    OnboardingContent(
      title: 'AI-Driven',
      titleItalicPart: 'Clarity.',
      description:
          'Our Gemini engine distills complex\nstories into 10-second summaries.',
      imagePath: 'assets/images/onboarding_ai.png',
    ),
    OnboardingContent(
      title: 'Verified Truth.',
      label: 'FINAL VERIFICATION',
      description:
          'Navigate the news with confidence using\n'
          'our real-time Truth Radar. Every headline\n'
          'is cross-referenced for architectural\n'
          'accuracy.',
      imagePath: 'assets/images/onboarding_verified.png',
    ),
  ];

  /// Advance to the next page. Returns `true` if already on the last page
  /// (caller should navigate to SignIn).
  bool nextPage() {
    if (state.isLastPage) return true;
    emit(state.copyWith(currentPage: state.currentPage + 1));
    return false;
  }

  /// Sync cubit state when the user swipes the PageView.
  void onPageChanged(int index) {
    emit(state.copyWith(currentPage: index));
  }
}
