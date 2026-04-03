import 'package:equatable/equatable.dart';

enum InterestsStatus { initial, loading, success, error }

class InterestsState extends Equatable {
  final Set<String> selectedInterests;
  final InterestsStatus status;
  final String? errorMessage;

  const InterestsState({
    this.selectedInterests = const {},
    this.status = InterestsStatus.initial,
    this.errorMessage,
  });

  int get selectedCount => selectedInterests.length;
  bool get canSubmit => selectedCount >= 3;
  int get remainingNeeded => (3 - selectedCount).clamp(0, 3);

  InterestsState copyWith({
    Set<String>? selectedInterests,
    InterestsStatus? status,
    String? errorMessage,
  }) {
    return InterestsState(
      selectedInterests: selectedInterests ?? this.selectedInterests,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [selectedInterests, status, errorMessage];
}

class InterestModel {
  final String label;
  final String emoji;

  const InterestModel({required this.label, required this.emoji});
}

const List<InterestModel> kInterests = [
  InterestModel(label: "World News", emoji: "🌎"),
  InterestModel(label: "Politics", emoji: "🏛️"),
  InterestModel(label: "Technology", emoji: "💻"),
  InterestModel(label: "Artificial Intelligence", emoji: "🤖"),
  InterestModel(label: "Business", emoji: "📈"),
  InterestModel(label: "Finance", emoji: "💰"),
  InterestModel(label: "Science", emoji: "🧪"),
  InterestModel(label: "Health", emoji: "🏥"),
  InterestModel(label: "Sports", emoji: "⚽"),
  InterestModel(label: "Climate", emoji: "🌱"),
  InterestModel(label: "Space", emoji: "🚀"),
  InterestModel(label: "Crypto & Web3", emoji: "₿"),
  InterestModel(label: "Entertainment", emoji: "🎬"),
  InterestModel(label: "Arts & Culture", emoji: "🎨"),
  InterestModel(label: "Travel", emoji: "✈️"),
  InterestModel(label: "Food & Lifestyle", emoji: "🍜"),
  InterestModel(label: "War & Conflict", emoji: "⚔️"),
  InterestModel(label: "Education", emoji: "📚"),
  InterestModel(label: "Crime & Justice", emoji: "⚖️"),
  InterestModel(label: "Economy", emoji: "🏦"),
];
