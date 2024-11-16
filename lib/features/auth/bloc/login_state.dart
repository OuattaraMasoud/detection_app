part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String? token;
  final String? userName;
  const LoginState({
    this.token,
    this.userName,
  });

  @override
  List<Object?> get props => [token, userName];
  LoginState copyWith({String? token, String? userName}) {
    return LoginState(
      userName: userName ?? this.userName,
      token: token ?? this.token,
    );
  }
}
