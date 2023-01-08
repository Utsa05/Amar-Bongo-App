import 'package:amar_bongo_app/data/data_sources/remote_data_source.dart';
import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/domain/entities/user.dart';
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class FirebaseRepositoryImpl implements FirebaseRepositories {
  final FirebaseRemoteDatasource remoteDatasource;

  FirebaseRepositoryImpl({required this.remoteDatasource});
  @override
  Future<UserEntity> getCurrentUser(String uid) async {
    return remoteDatasource.getCurrentUser(uid);
  }

  @override
  Future<String> getCurrentUserUID() async {
    return remoteDatasource.getCurrentUserUID();
  }

  @override
  Future<void> googleAuthentication() async {
    return remoteDatasource.googleAuthentication();
  }

  @override
  Future<bool> isUserSignin() async {
    return remoteDatasource.isUserSignin();
  }

  @override
  Future<void> signoutUser() async {
    return remoteDatasource.signoutUser();
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    return remoteDatasource.updateUser(user);
  }

  @override
  Future<void> createUser(UserEntity user) async {
    return remoteDatasource.createUser(user);
  }

  @override
  Stream<List<ItemEntity>> getItems() {
    return remoteDatasource.getItems();
  }
}
