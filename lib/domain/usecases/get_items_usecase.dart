// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class GetItemsUsecase {
  final FirebaseRepositories firebaseRepositories;
  GetItemsUsecase({
    required this.firebaseRepositories,
  });

  Stream<List<ItemEntity>> call() {
    return firebaseRepositories.getItems();
  }
}
