import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:foodapp/screens/ListOrder.dart';
import 'package:foodapp/screens/LogIn.dart';

import 'MyHomePage.dart';
import 'constants/constants.dart';
import 'firebase_options.dart';

void main() async{
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp( MyApp());
  // FlutterNativeSplash.remove();
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waiter App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: AppColor.primaryColor,
      ),
      home:
      MyHomePage(),
       routes: <String, WidgetBuilder> {
      '/ListOrder': (context) => ListOrder(),
      '/LogIn': (context) => LogIn(),
      
      
    },
    );
  }
}