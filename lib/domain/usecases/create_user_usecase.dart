// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amar_bongo_app/domain/entities/user.dart';
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class CreateUserUsecase {
  final FirebaseRepositories firebaseRepositories;
  CreateUserUsecase({
    required this.firebaseRepositories,
  });

  Future<void> call(UserEntity user) {
    return firebaseRepositories.createUser(user);
  }
}
