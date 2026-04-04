import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/article_mock_data.dart';

part 'channels_state.dart';

class ChannelsCubit extends Cubit<ChannelsState> {
  ChannelsCubit() : super(const ChannelsState());

  void load() {
    emit(state.copyWith(status: ChannelsStatus.loading));
    
    final channels = ArticleMockData.channels.map((c) => {
      'name': c['name']!,
      'followers': c['followers']!,
      'letter': c['letter']!,
      'isFollowed': false,
    }).toList();

    emit(state.copyWith(
      status: ChannelsStatus.loaded,
      channels: channels,
    ));
  }

  void toggleFollow(int index) {
    if (state.status != ChannelsStatus.loaded) return;
    
    final newChannels = List<Map<String, dynamic>>.from(state.channels);
    final channel = newChannels[index];
    newChannels[index] = {
      ...channel,
      'isFollowed': !channel['isFollowed'],
    };

    emit(state.copyWith(channels: newChannels));
  }
}
