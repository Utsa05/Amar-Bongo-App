// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class GetCurrentUser {
  final FirebaseRepositories firebaseRepositories;
  GetCurrentUser({
    required this.firebaseRepositories,
  });

  Future<void> getCurrentUser(String uid) {
    return firebaseRepositories.getCurrentUser(uid);
  }
}
