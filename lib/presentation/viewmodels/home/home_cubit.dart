import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/article_model.dart';

part 'home_state.dart';

/// Home screen business logic — manages selected category and article feed.
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  static const _categories = [
    'All',
    'Politics',
    'Technology',
    'Science',
    'Business',
    'Sports',
  ];

  static const _mockArticles = [
    ArticleModel(
      id: '1',
      title: 'Global AI Summit 2026: Key Takeaways and Future Projections',
      category: 'Technology',
      source: 'Reuters',
      timeAgo: '2h ago',
    ),
    ArticleModel(
      id: '2',
      title: 'Breakthrough in Quantum Computing Achieved by Research Team',
      category: 'Science',
      source: 'Nature',
      timeAgo: '4h ago',
    ),
    ArticleModel(
      id: '3',
      title: 'Markets Rally as Central Banks Signal Policy Shift',
      category: 'Business',
      source: 'Bloomberg',
      timeAgo: '6h ago',
    ),
    ArticleModel(
      id: '4',
      title: 'Champions League Semi-Finals Preview: What to Expect',
      category: 'Sports',
      source: 'ESPN',
      timeAgo: '8h ago',
    ),
    ArticleModel(
      id: '5',
      title: 'New Trade Agreements Reshape Global Economic Landscape',
      category: 'Politics',
      source: 'AP News',
      timeAgo: '12h ago',
    ),
  ];

  /// Load initial data.
  void load() {
    emit(
      state.copyWith(
        categories: _categories,
        articles: _mockArticles,
        selectedCategory: 'All',
      ),
    );
  }

  /// Select a category and filter articles.
  void selectCategory(String category) {
    final filtered = category == 'All'
        ? _mockArticles
        : _mockArticles.where((a) => a.category == category).toList();

    emit(state.copyWith(selectedCategory: category, articles: filtered));
  }
}
