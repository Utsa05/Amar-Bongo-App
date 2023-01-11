part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserIsLoading extends UserState {}

class UserIsNoInternet extends UserState {}

class UserIsLoaded extends UserState {
  final UserEntity user;

  UserIsLoaded({required this.user});
}

class UserIsFailure extends UserState {}
