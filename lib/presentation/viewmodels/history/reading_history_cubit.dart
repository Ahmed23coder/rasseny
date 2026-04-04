import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/article_mock_data.dart';
import '../../../data/models/article_model.dart';

part 'reading_history_state.dart';

class ReadingHistoryCubit extends Cubit<ReadingHistoryState> {
  ReadingHistoryCubit() : super(const ReadingHistoryState());

  void load() {
    emit(state.copyWith(status: HistoryStatus.loading));
    
    // Simulate grouped mock data
    final Map<String, List<ArticleModel>> grouped = {
      'Today': ArticleMockData.articles.sublist(0, 2),
      'Yesterday': ArticleMockData.articles.sublist(2, 4),
      'Earlier': ArticleMockData.articles.sublist(4),
    };

    emit(state.copyWith(
      status: HistoryStatus.loaded,
      groupedArticles: grouped,
    ));
  }

  void clearHistory() {
    emit(state.copyWith(groupedArticles: {}));
  }
}
