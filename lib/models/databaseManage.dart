import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodapp/models/product.dart';

class databaseManage{
  final  products = FirebaseFirestore.instance.collection('product') ;
  final  carts = FirebaseFirestore.instance.collection('cart');
  final orders = FirebaseFirestore.instance.collection('order');
  


  Stream<List<product>> getProduct() {
    return products.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => product.fromJson(doc)).toList();
    });
  }

  Future updateProduct(String docID, Map<String, dynamic> data) async{
    final document = products.doc(docID) ;
    await document.set(data);
  }

  // Stream<List<cart>> getCart() async* {
  //   final queryProduct = await products.get();
  //   final queryCart = carts.where('idProduct', isNotEqualTo: '').snapshots();

  //   await for (final snapshot in queryCart) {
  //     final listCart = snapshot.docs.map((doc) {
  //       final id_Product = doc['idProduct'];
  //       final product = queryProduct.docs.firstWhere((element) => element.id == id_Product);
  //       return cart(
  //         id: doc.id,
  //         idProduct: doc['idProduct'],
  //         quantity: doc['quantity'],
  //         name: product['name'],
  //         price: product['price'],
  //         image: product['image'],
  //       );
  //     }).toList();
  //     yield listCart;
  //   }
  // }


  // Future createCart(cart Carts) async{
  //   await carts.add(Carts.toJson());
  // }

  // Future updateCart(String docID, Map<String, dynamic> data) async{
  //   final document = await carts.doc(docID);
  //   await document.set(data);
  // }

  // Future deleteCart(String docID) async{
  //   final document = await carts.doc(docID);
  //   await document.delete();
  // }


  // Stream<List<order>> getOrder() {
  //   return orders.snapshots().asyncMap((snapshot) async {
  //     final orderList = <order>[];

  //     for (final orderDoc in snapshot.docs) {
  //       final idProductList = List<String>.from(orderDoc['idProduct']);
  //       final productList = <product>[];

  //       for (final idProduct in idProductList) {
  //         final productDoc = await orderDoc.reference.collection('product').doc(idProduct).get();

  //         if (productDoc.exists) {
  //           final productData = productDoc.data()!;
  //           productList.add(product(
  //             idProduct: idProduct,
  //             name: productData['name'],
  //             price: productData['price'],
  //             image: productData['image'],
  //             content: productData['content'],
  //             quantity: productData['quantity'],
  //             type: productData['type'],
  //             star: productData['star'],
  //             favorite: productData['favorite'],
  //           ));
  //         }
  //       }

  //       final sumPriceDoc = await orderDoc.reference.collection('sumPrice').doc('sumPrice').get();
  //       final sumPrice = sumPriceDoc.exists ? sumPriceDoc['sumPrice'] : 0;

  //       orderList.add(
  //           order(
  //         idOrder: orderDoc.id,
  //         products: productList,
  //         sumPrice: sumPrice,
  //       ));
  //     }

  //     return orderList;
  //   });
  // }




}





