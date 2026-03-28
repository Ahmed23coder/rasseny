import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchHomeNews extends HomeEvent {}

class SearchHomeNews extends HomeEvent {
  final String query;

  const SearchHomeNews(this.query);

  @override
  List<Object?> get props => [query];
}

class RefreshHomeNews extends HomeEvent {}
