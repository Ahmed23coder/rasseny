import 'package:equatable/equatable.dart';

enum OtpStatus { initial, loading, success, error }

class OtpState extends Equatable {
  final String code;
  final int secondsRemaining;
  final bool canResend;
  final OtpStatus status;
  final String? errorMessage;

  const OtpState({
    this.code = '',
    this.secondsRemaining = 60,
    this.canResend = false,
    this.status = OtpStatus.initial,
    this.errorMessage,
  });

  bool get isComplete => code.length == 6;

  String get formattedTime {
    final minutes = (secondsRemaining / 60).floor();
    final seconds = secondsRemaining % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  OtpState copyWith({
    String? code,
    int? secondsRemaining,
    bool? canResend,
    OtpStatus? status,
    String? errorMessage,
  }) {
    return OtpState(
      code: code ?? this.code,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      canResend: canResend ?? this.canResend,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [code, secondsRemaining, canResend, status, errorMessage];
}
