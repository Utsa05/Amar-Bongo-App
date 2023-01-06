// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amar_bongo_app/domain/entities/user.dart';
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class UpdateUsecase {
  final FirebaseRepositories firebaseRepositories;
  UpdateUsecase({
    required this.firebaseRepositories,
  });

  Future<void> updateUser(UserEntity user) {
    return firebaseRepositories.updateUser(user);
  }
}
