import 'package:amar_bongo_app/data/models/appinfo_model.dart';
import 'package:amar_bongo_app/domain/usecases/get_app_info_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'appinfo_state.dart';

class AppinfoCubit extends Cubit<AppinfoState> {
  final GetAppInfoUsecase getAppInfoUsecase;
  AppinfoCubit({required this.getAppInfoUsecase}) : super(AppinfoInitial());

  Future<void> getAppInfo() async {
    print('appinfocall');
    emit(AppinfoLoading());

    try {
      final appinfo = await getAppInfoUsecase.call();

      emit(AppinfoLoaded(appInfoModel: appinfo));
    } catch (e) {
      emit(AppinfoLoading());
    }
  }
}
