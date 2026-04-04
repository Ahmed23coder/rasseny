import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsState());

  void load() {
    emit(state.copyWith(status: NotificationsStatus.loading));
    
    // Simulate mock notifications
    final notifications = [
      {
        'id': '1',
        'title': 'New Breaking News',
        'body': 'AI detects major shift in global markets.',
        'time': '2m ago',
        'type': 'breaking',
        'isRead': false,
      },
      {
        'id': '2',
        'title': 'Article Saved',
        'body': 'Successfully added to your vault.',
        'time': '1h ago',
        'type': 'info',
        'isRead': true,
      },
      {
        'id': '3',
        'title': 'Fact Check Complete',
        'body': 'The disputed claim has been verified.',
        'time': '3h ago',
        'type': 'success',
        'isRead': true,
      },
    ];

    emit(state.copyWith(
      status: NotificationsStatus.loaded,
      notifications: notifications,
    ));
  }

  void markAsRead(String id) {
    if (state.status != NotificationsStatus.loaded) return;
    
    final newNotifications = state.notifications.map((n) {
      if (n['id'] == id) {
        return {...n, 'isRead': true};
      }
      return n;
    }).toList();

    emit(state.copyWith(notifications: newNotifications));
  }

  void clearAll() {
    emit(state.copyWith(notifications: []));
  }
}
