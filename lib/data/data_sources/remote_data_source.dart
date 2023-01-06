import 'package:amar_bongo_app/data/models/user_model.dart';
import 'package:amar_bongo_app/domain/entities/user.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseRemoteDatasource {
  Future<void> googleAuthentication();
  Future<void> signoutUser();
  Future<void> updateUser(UserEntity user);
  Future<String> getCurrentUserUID();
  Future<UserEntity> getCurrentUser(String uid);
  Future<bool> isUserSignin();
  Future<void> createUser(UserEntity user);
}

class FirebaseRemoteDatasourceImpl implements FirebaseRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFiresore;
  final GoogleSignIn googleSignin;

  FirebaseRemoteDatasourceImpl(
      {required this.firebaseAuth,
      required this.firebaseFiresore,
      required this.googleSignin});

  @override
  Future<UserEntity> getCurrentUser(String uid) async {
    final userCollection = firebaseFiresore.collection("users");

    UserEntity? currentUser;
    userCollection.doc(uid).get().then((value) {
      if (value.exists) {
        currentUser = UserEntity(
          uid: value.get('uid'),
          profileImage: value.get('profileImage'),
          name: value.get('name'),
          email: value.get('email'),
          isOnline: value.get('isOnline'),
          createdDate: value.get('createdDate'),
        );
      } else {
        currentUser = const UserEntity(
          uid: 'usernotavailable',
          profileImage: 'usernotavailable',
          name: 'usernotavailable',
          email: 'usernotavailable',
          isOnline: false,
          createdDate: 'usernotavailable',
        );
      }
    });
    return currentUser!;
  }

  @override
  Future<String> getCurrentUserUID() async {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Future<void> googleAuthentication() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignin.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth != null) {
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      firebaseAuth.signInWithCredential(credential).then((value) {
        User? firebaseUser = firebaseAuth.currentUser;
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        if (firebaseUser != null) {
          final newUser = UserEntity(
              uid: firebaseUser.uid,
              name: firebaseUser.displayName,
              email: firebaseUser.email,
              isOnline: true,
              createdDate: timestamp.toString());
          createUser(newUser);
        }
      });
    }
  }

  @override
  Future<bool> isUserSignin() async {
    return firebaseAuth.currentUser?.uid != null;
  }

  @override
  Future<void> signoutUser() async {
    return firebaseAuth.signOut();
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firebaseFiresore.collection("users");
    final uid = await getCurrentUserUID();

    userCollection.doc(uid).get().then((item) {
      if (item.exists) {
        final updateUser = UserModel(
          profileImage: user.profileImage,
          name: user.name,
          email: user.email,
        ).toDocument();

        userCollection
            .doc(uid)
            .update(updateUser)
            .then((value) => print("updated"));
      }
    });
  }

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firebaseFiresore.collection("users");
    final uid = await getCurrentUserUID();

    userCollection.doc(uid).get().then((item) {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      final newUser = UserModel(
              uid: user.uid,
              name: user.name,
              email: user.email,
              isOnline: true,
              createdDate: timestamp.toString())
          .toDocument();
      if (!item.exists) {
        userCollection.doc(uid).set(newUser);
      }
    });
  }
}
