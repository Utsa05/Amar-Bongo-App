import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/domain/entities/user.dart';

abstract class FirebaseRepositories {
  Future<void> googleAuthentication();
  Future<void> signoutUser();
  Future<void> updateUser(UserEntity user);
  Future<void> createUser(UserEntity user);
  Future<String> getCurrentUserUID();
  Future<UserEntity> getCurrentUser(String uid);
  Future<bool> isUserSignin();
  Stream<List<ItemEntity>> getItems();
}
