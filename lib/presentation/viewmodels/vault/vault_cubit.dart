import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/article_mock_data.dart';
import '../../../data/models/article_model.dart';

part 'vault_state.dart';

class VaultCubit extends Cubit<VaultState> {
  VaultCubit() : super(const VaultState());

  void load() {
    emit(state.copyWith(status: VaultStatus.loading));
    
    // Simulate saved articles from mock data
    final saved = ArticleMockData.articles.sublist(0, 3);

    emit(state.copyWith(
      status: VaultStatus.loaded,
      savedArticles: saved,
    ));
  }

  void toggleSelection(String id) {
    final newSelection = Set<String>.from(state.selectedIds);
    if (newSelection.contains(id)) {
      newSelection.remove(id);
    } else {
      newSelection.add(id);
    }
    emit(state.copyWith(selectedIds: newSelection));
  }

  void clearSelection() {
    emit(state.copyWith(selectedIds: {}));
  }

  void deleteSelected() {
    final remaining = state.savedArticles.where((a) => !state.selectedIds.contains(a.id)).toList();
    emit(state.copyWith(
      savedArticles: remaining,
      selectedIds: {},
    ));
  }
}
