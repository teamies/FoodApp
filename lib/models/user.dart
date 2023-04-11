import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String? id;
  String name;
  String email;
  String password;

  Users(
      {this.id,
        required this.email,
        required this.name,
        required this.password,
      });

  factory Users.fromFirestore(DocumentSnapshot doc)
  {
    Map data = doc.data() as Map<String, dynamic>;
    return Users(
        id: data['uid'],
        email : data['email'],
        name : data['name'],
        password : data['password'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name':name,
      'email':email,
      'password': password,
    };
  }
}


