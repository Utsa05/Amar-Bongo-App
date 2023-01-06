import 'package:amar_bongo_app/domain/entities/user.dart';

abstract class FirebaseRemoteDatasource {
  Future<void> googleAuthentication();
  Future<void> signoutUser();
  Future<void> updateUser(UserEntity user);
  Future<String> getCurrentUserUID();
  Future<UserEntity> getCurrentUser(String uid);
  Future<bool> isUserSignin();
}

class FirebaseRemoteDatasourceImpl implements FirebaseRemoteDatasource {
  @override
  Future<UserEntity> getCurrentUser(String uid) {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> getCurrentUserUID() {
    // TODO: implement getCurrentUserUID
    throw UnimplementedError();
  }

  @override
  Future<void> googleAuthentication() {
    // TODO: implement googleAuthentication
    throw UnimplementedError();
  }

  @override
  Future<bool> isUserSignin() {
    // TODO: implement isUserSignin
    throw UnimplementedError();
  }

  @override
  Future<void> signoutUser() {
    // TODO: implement signoutUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(UserEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
