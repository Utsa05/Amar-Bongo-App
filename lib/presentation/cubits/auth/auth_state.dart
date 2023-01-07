part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final String uid;

  Authenticated({required this.uid});
}

class UnAuthenticated extends AuthState {}
