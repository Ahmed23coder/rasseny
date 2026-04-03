import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final PageController pageController;

  OnboardingCubit() 
      : pageController = PageController(initialPage: 0),
        super(OnboardingState.initial());

  void onPageChanged(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void nextPage() {
    if (state.currentPage < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void skipToAuth() {
    // Handled by router listening or direct UI button, 
    // but can be tracked here if needed.
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
