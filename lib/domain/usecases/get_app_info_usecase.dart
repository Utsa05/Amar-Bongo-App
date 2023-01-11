// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amar_bongo_app/data/models/appinfo_model.dart';
import 'package:amar_bongo_app/domain/entities/AppInfo.dart';
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class GetAppInfoUsecase {
  final FirebaseRepositories firebaseRepositories;
  GetAppInfoUsecase({
    required this.firebaseRepositories,
  });

  Future<AppInfoModel> call() {
    return firebaseRepositories.getAppInfo();
  }
}
