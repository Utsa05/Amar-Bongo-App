import 'dart:io';

import 'package:amar_bongo_app/data/models/appinfo_model.dart';
import 'package:amar_bongo_app/domain/usecases/get_app_info_usecase.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'appinfo_state.dart';

class AppinfoCubit extends Cubit<AppinfoState> {
  final GetAppInfoUsecase getAppInfoUsecase;
  AppinfoCubit({required this.getAppInfoUsecase}) : super(AppinfoInitial());

  Future<void> getAppInfo() async {
    // ignore: avoid_print
    print('appinfocall');
    emit(AppinfoLoading());

    try {
      final appinfo = await getAppInfoUsecase.call();

      emit(AppinfoLoaded(appInfoModel: appinfo));
    } on SocketException {
      emit(AppinfoNoInternet());
    } catch (e) {
      emit(AppinfoLoading());
    }
  }
}
