part of 'home_menu_cubit.dart';

class HomeMenuState extends Equatable {
  final String activeRoute;

  const HomeMenuState({
    this.activeRoute = AppRouter.shell,
  });

  HomeMenuState copyWith({
    String? activeRoute,
  }) {
    return HomeMenuState(
      activeRoute: activeRoute ?? this.activeRoute,
    );
  }

  @override
  List<Object?> get props => [activeRoute];
}
