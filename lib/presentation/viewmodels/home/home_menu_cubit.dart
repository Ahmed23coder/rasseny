import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/app_router.dart';

part 'home_menu_state.dart';

class HomeMenuCubit extends Cubit<HomeMenuState> {
  HomeMenuCubit() : super(const HomeMenuState());

  static const List<Map<String, dynamic>> menuItems = [
    {'title': 'Reading History', 'route': AppRouter.readingHistory, 'icon': 'history'},
    {'title': 'Vault', 'route': AppRouter.savedArticles, 'icon': 'bookmark'},
    {'title': 'My Channels', 'route': '/my-channels', 'icon': 'tv'},
    {'title': 'Language', 'route': AppRouter.language, 'icon': 'globe'},
    {'title': 'Notifications', 'route': AppRouter.notifications, 'icon': 'bell'},
    {'title': 'App Settings', 'route': AppRouter.appSettings, 'icon': 'settings'},
    {'title': 'Subscription', 'route': AppRouter.subscription, 'icon': 'credit-card'},
    {'title': 'About', 'route': AppRouter.about, 'icon': 'info'},
  ];

  void selectItem(String route) {
    emit(state.copyWith(activeRoute: route));
  }
}
