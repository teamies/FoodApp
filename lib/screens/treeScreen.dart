
import 'package:flutter/material.dart';
import 'package:foodapp/screens/ListOrder.dart';

import '../database/services/auth_service.dart';
import 'LogIn.dart';
class treeScreen extends StatefulWidget {
  const treeScreen({super.key});

  @override
  State<treeScreen> createState() => _treeScreenState();
}

class _treeScreenState extends State<treeScreen> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListOrder();
        }else{
          return LogIn();
        }
      },
    );
  }
}