import 'package:cloud_firestore/cloud_firestore.dart';

class product{
  String? idProduct;
  String content;
  String image;
  String name;
  num price;
  num quantity;
  String type;
  num star;
  bool favorite;

  product(
      {this.idProduct,
        required this.content,
        required this.image,
        required this.name,
        required this.price,
        required this.quantity,
        required this.type,
        required this.star,
        required this.favorite
      });

  factory product.fromJson(DocumentSnapshot doc)
  {
    Map data = doc.data() as Map<String, dynamic>;
    return product(
        idProduct: doc.id,
        content : data['content'],
        price : data['price'],
        image : data['image'],
        name : data['name'],
        quantity : data['quantity'],
        type : data['type'],
      star: data['star'],
      favorite: data['favorite'],
    );
  }

}


