import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashNavigating extends SplashState {}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  /// Initializes the app (e.g. loads tokens, user profile).
  void initializeApp() async {
    // Simulate initialization delay to let splash screen show
    await Future.delayed(const Duration(milliseconds: 4000));

    if (!isClosed) {
      emit(SplashNavigating());
    }
  }
}
