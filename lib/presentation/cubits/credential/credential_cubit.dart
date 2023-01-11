// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:amar_bongo_app/domain/usecases/google_authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final GoogleAuthenticationUsecase googleAuthenticationUsecase;

  CredentialCubit({required this.googleAuthenticationUsecase})
      : super(CredentialInitial());

  Future<void> googleAuthentication() async {
    emit(CredentialLoading());
    try {
      await googleAuthenticationUsecase.call();

      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialNoInternet());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  // Future<UserEntity> getCurrentUserInfo(String uid) async {
  //   emit(CredentialLoading());
  //   try {
  //     emit(CredentialSuccess());

  //     return await getCurrentUser.call(uid);
  //   } on SocketException catch (_) {
  //     emit(CredentialFailure());
  //   } catch (_) {
  //     emit(CredentialFailure());
  //   }
  //   return const UserEntity();
  // }
}
