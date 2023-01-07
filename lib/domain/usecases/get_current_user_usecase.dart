// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amar_bongo_app/domain/entities/user.dart';
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class GetCurrentUserUsecase {
  final FirebaseRepositories firebaseRepositories;
  GetCurrentUserUsecase({
    required this.firebaseRepositories,
  });

  Future<UserEntity> call(String uid) {
    return firebaseRepositories.getCurrentUser(uid);
  }
}
