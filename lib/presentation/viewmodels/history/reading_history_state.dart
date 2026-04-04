part of 'reading_history_cubit.dart';

enum HistoryStatus { initial, loading, loaded, error }

class ReadingHistoryState extends Equatable {
  final HistoryStatus status;
  final Map<String, List<ArticleModel>> groupedArticles;
  final String? errorMessage;

  const ReadingHistoryState({
    this.status = HistoryStatus.initial,
    this.groupedArticles = const {},
    this.errorMessage,
  });

  ReadingHistoryState copyWith({
    HistoryStatus? status,
    Map<String, List<ArticleModel>>? groupedArticles,
    String? errorMessage,
  }) {
    return ReadingHistoryState(
      status: status ?? this.status,
      groupedArticles: groupedArticles ?? this.groupedArticles,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, groupedArticles, errorMessage];
}
