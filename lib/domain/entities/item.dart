// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String? id;
  final String? title;
  final String? image;
  final String? category;
  final String? url;

  const ItemEntity(this.category, {this.id, this.title, this.image, this.url});

  @override
  List<Object?> get props => [id, title];
}
