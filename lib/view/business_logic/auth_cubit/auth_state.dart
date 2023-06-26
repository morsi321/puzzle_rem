part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthDataChanged extends AuthState {}

class LoadingState extends AuthState {}

class SuccessState extends AuthState {}

class FailureState extends AuthState {
  final String msg;

  FailureState(this.msg);
}
