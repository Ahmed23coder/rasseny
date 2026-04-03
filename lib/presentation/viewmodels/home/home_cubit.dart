import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/article_model.dart';
import '../../../domain/repositories/news_repository.dart';

part 'home_state.dart';

/// Home screen business logic — manages selected category and article feed.
class HomeCubit extends Cubit<HomeState> {
  final NewsRepository _newsRepository;

  HomeCubit(this._newsRepository) : super(const HomeState());

  /// Load initial data.
  Future<void> load() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final categories = await _newsRepository.getCategories();
      final articles = await _newsRepository.getTrendingArticles();
      emit(
        state.copyWith(
          status: HomeStatus.loaded,
          categories: categories,
          articles: articles,
          selectedCategory: 'All',
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Select a category and filter articles.
  Future<void> selectCategory(String category) async {
    emit(state.copyWith(status: HomeStatus.loading, selectedCategory: category));
    try {
      final articles = await _newsRepository.getArticlesByCategory(category);
      emit(state.copyWith(status: HomeStatus.loaded, articles: articles));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
