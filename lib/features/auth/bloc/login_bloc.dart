import 'package:bloc/bloc.dart';
import 'package:detectionApp/features/main/main_screen.dart';
import 'package:detectionApp/global_app/cubit/global_app_cubit.dart';
import 'package:detectionApp/repositories/repository.dart';
import 'package:detectionApp/services/local_storage_service.dart';
import 'package:detectionApp/services/locator.dart';
import 'package:detectionApp/services/navigation_service.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DetectionRepository _detectionRepository;
  LoginBloc(this._detectionRepository) : super(LoginState()) {
    on<LogUser>(_logUser);
  }

  void _logUser(LogUser event, Emitter emit) async {
    Map<String, dynamic>? jsonResponse =
        await _detectionRepository.login(event.userData);
    print(jsonResponse);
    if (jsonResponse != null) {
      locator<LocalStorageService>().token = jsonResponse['token'];
      locator<LocalStorageService>().userName = event.userData['username'];
      emit(state.copyWith(
          token: jsonResponse['token'], userName: event.userData['username']));
      locator<GlobalAppCubit>().stopLoading();

      locator<NavigationService>().replaceWith(MainScreen.routeName);
    }
  }
}
