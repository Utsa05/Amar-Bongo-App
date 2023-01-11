// ignore_for_file: avoid_print

import 'package:amar_bongo_app/data/models/appinfo_model.dart';
import 'package:amar_bongo_app/data/models/item_model.dart';
import 'package:amar_bongo_app/data/models/notification_model.dart';
import 'package:amar_bongo_app/data/models/user_model.dart';
import 'package:amar_bongo_app/domain/entities/item.dart';

import 'package:amar_bongo_app/domain/entities/notification.dart';
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
  Stream<List<ItemEntity>> getItems();
  Stream<List<NotificationEntity>> getNotifications();
  Future<AppInfoModel> getAppInfo();
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

    // ignore: null_argument_to_non_null_type
    return userCollection.doc(uid).get().then((value) {
      UserEntity? currentUser = const UserEntity(
        uid: 'usernotavailable',
        profileImage: 'usernotavailable',
        name: 'usernotavailable',
        email: 'usernotavailable',
        isOnline: false,
        createdDate: 'usernotavailable',
      );

      currentUser = UserEntity(
        uid: value.get('uid'),
        profileImage: value.get('profileImage'),
        name: value.get('name'),
        email: value.get('email'),
        isOnline: value.get('isOnline'),
        createdDate: value.get('createdDate'),
      );
      return currentUser;
    });
  }

  @override
  Future<String> getCurrentUserUID() async {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Future<void> googleAuthentication() async {
    final usersCollection = firebaseFiresore.collection("users");

    try {
      final GoogleSignInAccount? account = await googleSignin.signIn();
      final GoogleSignInAuthentication googleAuth =
          await account!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      final information =
          (await firebaseAuth.signInWithCredential(credential)).user;
      usersCollection
          .doc(firebaseAuth.currentUser!.uid)
          .get()
          .then((user) async {
        if (!user.exists) {
          var uid = firebaseAuth.currentUser!.uid;
          var newUser = UserModel(
                  uid: information!.uid,
                  name: information.displayName,
                  email: information.email,
                  profileImage: information.photoURL,
                  isOnline: true,
                  createdDate: timestamp.toString())
              .toDocument();

          usersCollection.doc(uid).set(newUser);
        }
      }).whenComplete(() {
        print("Successfull");
      }).catchError((e) {});
    } catch (e) {
      print(e);
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

  @override
  Stream<List<ItemEntity>> getItems() {
    final collection = firebaseFiresore.collection("items");

    return collection
        .orderBy('title')
        .snapshots()
        .map((event) => event.docs.map((e) {
              print(e.get('title') ?? "empty");
              print(e.get('address') ?? "empty");
              return ItemModel.fromSnapshot(e);
            }).toList());
  }

  @override
  Stream<List<NotificationEntity>> getNotifications() {
    final collection = firebaseFiresore.collection("notifications");
    return collection.snapshots().map((event) =>
        event.docs.map((e) => NotificationModel.fromSnapshot(e)).toList());
  }

  @override
  Future<AppInfoModel> getAppInfo() async {
    final collection =
        firebaseFiresore.collection("appinfo").doc('WTmNxTYT7WDpzsTcijIX');

    return collection.get().then((value) {
      if (value.exists) {
        print(value.get('addstatus'));
        return AppInfoModel(
          addstatus: value.get('addstatus'),
          shareapp: value.get('shareapp'),
          othersapp: value.get('othersapp'),
          bannerad: value.get('bannerad'),
          interstitialad: value.get('interstitialad'),
          videoad: value.get('videoad'),
          policy: value.get('policy'),
        );
      } else {
        print('app info not exist');
        return const AppInfoModel(
          addstatus: 'nothing',
          bannerad: 'nothing',
          videoad: 'nothing',
          interstitialad: 'nothing',
          shareapp: 'nothing',
          othersapp: 'nothing',
        );
      }
    });
  }
}
