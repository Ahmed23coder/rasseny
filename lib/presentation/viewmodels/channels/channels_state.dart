part of 'channels_cubit.dart';

enum ChannelsStatus { initial, loading, loaded, error }

class ChannelsState extends Equatable {
  final ChannelsStatus status;
  final List<Map<String, dynamic>> channels;
  final String? errorMessage;

  const ChannelsState({
    this.status = ChannelsStatus.initial,
    this.channels = const [],
    this.errorMessage,
  });

  ChannelsState copyWith({
    ChannelsStatus? status,
    List<Map<String, dynamic>>? channels,
    String? errorMessage,
  }) {
    return ChannelsState(
      status: status ?? this.status,
      channels: channels ?? this.channels,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, channels, errorMessage];
}
