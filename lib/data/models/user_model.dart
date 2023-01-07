import 'package:amar_bongo_app/domain/entities/user.dart';

// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  const UserModel({
    final String? uid,
    final String? profileImage,
    final String? name,
    final String? email,
    final bool? isOnline,
    final String? createdDate,
  }) : super(
            uid: uid,
            profileImage: profileImage,
            name: name,
            email: email,
            isOnline: isOnline,
            createdDate: createdDate);

  factory UserModel.fromSnapshort(DocumentSnapshot snapshot) {
    return UserModel(
        uid: snapshot.get('uid'),
        profileImage: snapshot.get('profileImage'),
        name: snapshot.get('name'),
        email: snapshot.get('email'),
        isOnline: snapshot.get('isOnline'),
        createdDate: snapshot.get('createdDate'));
  }

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'profileImage': profileImage,
      'name': name,
      'email': email,
      'isOnline': isOnline,
      'createdDate': createdDate
    };
  }
}
