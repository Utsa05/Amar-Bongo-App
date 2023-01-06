// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class GoogleAuthenticationUsecase {
  final FirebaseRepositories firebaseRepositories;
  GoogleAuthenticationUsecase({
    required this.firebaseRepositories,
  });

  Future<void> googleAuthentication() {
    return firebaseRepositories.googleAuthentication();
  }
}
