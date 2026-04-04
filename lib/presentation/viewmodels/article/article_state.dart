part of 'article_cubit.dart';

enum ArticleStatus { initial, loading, loaded, error }

class ArticleState extends Equatable {
  final ArticleStatus status;
  final ArticleModel? article;
  final bool isSaved;
  final String? errorMessage;

  const ArticleState({
    this.status = ArticleStatus.initial,
    this.article,
    this.isSaved = false,
    this.errorMessage,
  });

  ArticleState copyWith({
    ArticleStatus? status,
    ArticleModel? article,
    bool? isSaved,
    String? errorMessage,
  }) {
    return ArticleState(
      status: status ?? this.status,
      article: article ?? this.article,
      isSaved: isSaved ?? this.isSaved,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, article, isSaved, errorMessage];
}
