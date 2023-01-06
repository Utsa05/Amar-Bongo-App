// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class SignoutUsecase {
  final FirebaseRepositories firebaseRepositories;
  SignoutUsecase({
    required this.firebaseRepositories,
  });

  Future<void> signoutUser() {
    return firebaseRepositories.signoutUser();
  }
}
