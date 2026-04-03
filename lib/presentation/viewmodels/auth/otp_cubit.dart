import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepository _repository;
  Timer? _timer;

  OtpCubit(this._repository) : super(const OtpState()) {
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    emit(state.copyWith(secondsRemaining: 60, canResend: false));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        emit(state.copyWith(secondsRemaining: state.secondsRemaining - 1));
      } else {
        emit(state.copyWith(canResend: true));
        _timer?.cancel();
      }
    });
  }

  void updateCode(String code) {
    emit(state.copyWith(code: code, status: OtpStatus.initial));
  }

  Future<void> resend() async {
    if (!state.canResend) return;
    
    try {
      await _repository.resendOtp();
      _startTimer();
    } catch (e) {
      emit(state.copyWith(
        status: OtpStatus.error,
        errorMessage: e.toString().replaceAll("Exception: ", ""),
      ));
    }
  }

  Future<void> verify() async {
    if (!state.isComplete) return;

    emit(state.copyWith(status: OtpStatus.loading));

    try {
      await _repository.verifyOtp(state.code);
      emit(state.copyWith(status: OtpStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: OtpStatus.error,
        errorMessage: e.toString().replaceAll("Exception: ", ""),
      ));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
