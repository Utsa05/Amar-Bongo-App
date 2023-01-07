// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class GetCurrentUserIDUsecase {
  final FirebaseRepositories firebaseRepositories;
  GetCurrentUserIDUsecase({
    required this.firebaseRepositories,
  });

  Future<String> call() {
    return firebaseRepositories.getCurrentUserUID();
  }
}
