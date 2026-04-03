part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<String> categories;
  final String selectedCategory;
  final List<ArticleModel> articles;

  const HomeState({
    this.categories = const [],
    this.selectedCategory = 'All',
    this.articles = const [],
  });

  HomeState copyWith({
    List<String>? categories,
    String? selectedCategory,
    List<ArticleModel>? articles,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object?> get props => [categories, selectedCategory, articles];
}
