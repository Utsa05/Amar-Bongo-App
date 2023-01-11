// ignore_for_file: depend_on_referenced_packages

import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel extends ItemEntity {
  const ItemModel({
    final String? id,
    final String? title,
    final String? image,
    final String? category,
    final String? url,
    final String? address,
    final String? type,
  }) : super(
            id: id,
            title: title,
            image: image,
            category: category,
            url: url,
            address: address,
            type: type);

  factory ItemModel.fromSnapshot(DocumentSnapshot snapshot) {
    return ItemModel(
      id: snapshot.get('id'),
      title: snapshot.get('title'),
      image: snapshot.get('image'),
      category: snapshot.get('category'),
      url: snapshot.get('url'),
      address: snapshot.get('address') ?? "",
      type: snapshot.get('type') ?? "",
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'category': category,
      'url': url,
      'address': address,
      'type': type,
    };
  }
}

class ItemFavModel extends ItemfavEntity {
  const ItemFavModel({
    final int? id,
    final String? title,
    final String? image,
    final String? category,
    final String? url,
  }) : super(
          id: id,
          title: title,
          image: image,
          category: category,
          url: url,
        );

  factory ItemFavModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return ItemFavModel(
      id: snapshot['id'],
      title: snapshot['title'],
      image: snapshot['image'],
      category: snapshot['category'],
      url: snapshot['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'category': category,
      'url': url
    };
  }
}
