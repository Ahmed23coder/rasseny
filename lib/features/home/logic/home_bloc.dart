import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;

  HomeBloc(this._repository) : super(HomeInitial()) {
    on<FetchHomeNews>(_onFetchNews);
    on<SearchHomeNews>(_onSearchNews);
    on<RefreshHomeNews>(_onRefreshNews);
  }

  Future<void> _onFetchNews(FetchHomeNews event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final articles = await _repository.fetchTopHeadlines();
      emit(HomeLoaded(articles));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onSearchNews(SearchHomeNews event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final articles = await _repository.searchNews(event.query);
      emit(HomeLoaded(articles));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefreshNews(RefreshHomeNews event, Emitter<HomeState> emit) async {
    try {
      final articles = await _repository.fetchTopHeadlines();
      emit(HomeLoaded(articles));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
