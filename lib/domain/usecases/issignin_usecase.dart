// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class IsSigninUsecase {
  final FirebaseRepositories firebaseRepositories;
  IsSigninUsecase({
    required this.firebaseRepositories,
  });

  Future<bool> call() {
    return firebaseRepositories.isUserSignin();
  }
}
