part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LogUser extends LoginEvent {
  final Map<String, dynamic> userData;
  const LogUser({
    required this.userData,
  });
}
