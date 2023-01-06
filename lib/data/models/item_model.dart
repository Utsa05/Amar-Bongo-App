import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel extends ItemEntity {
  const ItemModel(
      {final String? id,
      final String? title,
      final String? image,
      final String? category,
      final String? url})
      : super(id: id, title: title, image: image, category: category, url: url);

  factory ItemModel.fromSnapshot(DocumentSnapshot snapshot) {
    return ItemModel(
        id: snapshot.get('id'),
        title: snapshot.get('title'),
        image: snapshot.get('image'),
        category: snapshot.get('category'),
        url: snapshot.get('url'));
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'category': category,
      'url': url
    };
  }
}
