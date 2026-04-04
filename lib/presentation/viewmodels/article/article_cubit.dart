import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/article_mock_data.dart';
import '../../../data/models/article_model.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(const ArticleState());

  void loadArticle(String id) {
    emit(state.copyWith(status: ArticleStatus.loading));
    
    // Simulate fetching from mock data
    final article = ArticleMockData.articles.firstWhere(
      (a) => a.id == id,
      orElse: () => ArticleMockData.articles[0],
    );

    emit(state.copyWith(
      status: ArticleStatus.loaded,
      article: article,
    ));
  }

  void toggleSave() {
    emit(state.copyWith(isSaved: !state.isSaved));
  }
}
