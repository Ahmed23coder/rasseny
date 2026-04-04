part of 'vault_cubit.dart';

enum VaultStatus { initial, loading, loaded, error }

class VaultState extends Equatable {
  final VaultStatus status;
  final List<ArticleModel> savedArticles;
  final Set<String> selectedIds;
  final String? errorMessage;

  const VaultState({
    this.status = VaultStatus.initial,
    this.savedArticles = const [],
    this.selectedIds = const {},
    this.errorMessage,
  });

  VaultState copyWith({
    VaultStatus? status,
    List<ArticleModel>? savedArticles,
    Set<String>? selectedIds,
    String? errorMessage,
  }) {
    return VaultState(
      status: status ?? this.status,
      savedArticles: savedArticles ?? this.savedArticles,
      selectedIds: selectedIds ?? this.selectedIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, savedArticles, selectedIds, errorMessage];
}
