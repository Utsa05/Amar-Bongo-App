// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages, avoid_print
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:amar_bongo_app/domain/entities/user.dart';
import 'package:amar_bongo_app/domain/usecases/get_current_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  UserCubit({required this.getCurrentUserUsecase}) : super(UserInitial());

  Future<void> getCurrentUser(String uid) async {
    print('User calling');
    emit(UserIsLoading());
    try {
      final user = await getCurrentUserUsecase.call(uid);

      print('User laoded');
      print(user.email);

      emit(UserIsLoaded(user: user));
    } on SocketException {
      emit(UserIsFailure());
    } catch (e) {
      print("user failur");
      print(e);
      emit(UserIsFailure());
    }
  }
}
