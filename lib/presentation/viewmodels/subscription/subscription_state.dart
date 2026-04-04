part of 'subscription_cubit.dart';

class SubscriptionState extends Equatable {
  final int selectedPlanIndex;

  const SubscriptionState({
    this.selectedPlanIndex = 0, // 0: Free, 1: Pro
  });

  SubscriptionState copyWith({
    int? selectedPlanIndex,
  }) {
    return SubscriptionState(
      selectedPlanIndex: selectedPlanIndex ?? this.selectedPlanIndex,
    );
  }

  @override
  List<Object?> get props => [selectedPlanIndex];
}
