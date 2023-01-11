// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:io';

import 'package:amar_bongo_app/domain/usecases/getcurrent_user_id_usecase.dart';
import 'package:amar_bongo_app/domain/usecases/issignin_usecase.dart';
import 'package:amar_bongo_app/domain/usecases/signout_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSigninUsecase isSigninUsecase;
  final GetCurrentUserIDUsecase getCurrentUserIDUsecase;
  final SignoutUsecase signoutUsecase;
  AuthCubit(
      {required this.isSigninUsecase,
      required this.getCurrentUserIDUsecase,
      required this.signoutUsecase})
      : super(AuthInitial());
  Future<void> appStarted() async {
    print("appstart");
    try {
      bool isSignIn = await isSigninUsecase.call();
      print(isSignIn);
      if (isSignIn == true) {
        final uid = await getCurrentUserIDUsecase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      print("jamela");
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUserIDUsecase.call();

      print("user Id $uid");
      emit(Authenticated(uid: uid));
    } on SocketException {
      emit(AuthNoInternet());
    } catch (_) {
      print("user Id null");
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signoutUsecase.call();
      emit(UnAuthenticated());
    } on SocketException {
      emit(AuthNoInternet());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
