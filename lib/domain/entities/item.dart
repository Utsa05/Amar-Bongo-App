// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String? id;
  final String? title;
  final String? image;
  final String? category;
  final String? url;
  final String? address;
  final String? type;

  const ItemEntity(
      {this.id,
      this.title,
      this.image,
      this.category,
      this.url,
      this.address,
      this.type});

  @override
  List<Object?> get props => [id, title];
}

class ItemfavEntity extends Equatable {
  final int? id;
  final String? title;
  final String? image;
  final String? category;
  final String? url;
  final String? address;
  final String? type;

  const ItemfavEntity(
      {this.id,
      this.title,
      this.image,
      this.category,
      this.url,
      this.address,
      this.type});

  @override
  List<Object?> get props => [id, title];
}
