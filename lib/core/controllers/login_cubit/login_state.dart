part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginDoneState extends LoginState {
  final UserModel userModel;
  LoginDoneState({required this.userModel});
}
class LoginErrorState extends LoginState {}

