part of 'home_cubit.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<String> categories;
  final String selectedCategory;
  final List<ArticleModel> articles;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.categories = const [],
    this.selectedCategory = 'All',
    this.articles = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<String>? categories,
    String? selectedCategory,
    List<ArticleModel>? articles,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      articles: articles ?? this.articles,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, categories, selectedCategory, articles, errorMessage];
}
