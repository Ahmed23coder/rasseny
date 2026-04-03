import 'package:flutter_bloc/flutter_bloc.dart';
import 'interests_state.dart';

class InterestsCubit extends Cubit<InterestsState> {
  InterestsCubit() : super(const InterestsState());

  void toggleInterest(String label) {
    final updated = Set<String>.from(state.selectedInterests);
    if (updated.contains(label)) {
      updated.remove(label);
    } else {
      updated.add(label);
    }
    emit(state.copyWith(selectedInterests: updated));
  }

  Future<void> submit() async {
    if (!state.canSubmit) return;

    emit(state.copyWith(status: InterestsStatus.loading));
    
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Success simulation
    emit(state.copyWith(status: InterestsStatus.success));
  }
}
