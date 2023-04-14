import 'package:cloud_firestore/cloud_firestore.dart';

class orderCard {
  String? idOrderCard;
  String foodname;
  num? price;
  String? mainMaterial;
  String? image;
  num quantity;
  String? size;
  bool? status;
  num? table;

  orderCard(
      {this.idOrderCard,
      required this.foodname,
      this.mainMaterial,
      this.price,
      this.image,
      required this.quantity,
      required this.size,
      required this.status,
      required this.table});

  factory orderCard.fromJson(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    // print(data);
    return orderCard(
      idOrderCard: doc.id,
      foodname: data['Foodname'],
      image: data['img'],
      mainMaterial: data['mainMaterial'] != null ? data['mainMaterial'] : null,
      price: data['price'],
      quantity: data['quantity'],
      size: data['size'] != null ? data['size'] : null,
      status: data['status'],
      table: data['table'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'idProduct': idProduct,
      'quantity': quantity
    };
  }
}
