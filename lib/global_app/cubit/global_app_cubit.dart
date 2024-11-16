import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'global_app_state.dart';

class GlobalAppCubit extends Cubit<GlobalAppState> {
  GlobalAppCubit() : super(GlobalAppInitial());

  void startLoading() {
    emit(GlobalAppLoadingStarted());
  }

  void stopLoading() {
    emit(GlobalAppInitial());
  }

  void lockScreen() {
    emit(GlobalAppScreenLocked());
  }

  void unlockScreen() {
    emit(GlobalAppScreenUnlocked());
  }
}
