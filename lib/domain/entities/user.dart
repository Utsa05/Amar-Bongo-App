// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? profileImage;
  final String? name;
  final String? email;
  final bool? isOnline;
  final String? createdDate;

  const UserEntity(
      {this.uid,
      this.profileImage,
      this.name,
      this.email,
      this.isOnline,
      this.createdDate});

  @override
  List<Object?> get props => [uid, name];
}
