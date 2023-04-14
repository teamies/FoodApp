import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodapp/screens/ForgotPassword.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../components/mytext.dart';
import '../constants/constants.dart';
import '../core/_config.dart';
import '../database/services/auth_service.dart';
import 'SignUp.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? errorMesage = '';
  static bool _isObscure = true;
  // bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<dynamic> signInWithEmailAndPassword() async {
    try {
      Auth().updatePassword(
          uid: _controllerEmail.text,
          password: _controllerPassword.text,
          ConfirmPassword: _controllerPassword.text);
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, '/ListOrder', (route) => false);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMesage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMesage = e.message;
      });
    }
  }

  Widget _entryField(
      {required String title,
      IconData? iconVisibility_off,
      IconData? iconVisibility,
      required bool isObscure,
      required TextEditingController controller,
      GestureTapCallback? onPressed}) {
    return Container(
      // decoration: BoxDecoration(border: Border.all()),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText.baseText(
                  text: title, size: 12, fontWeight: FontWeight.w600),
              MyText.baseText(text: "*", size: 12, color: primaryColor)
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            height: 58,
            child: TextFormField(
              controller: controller,
              textInputAction: TextInputAction.done,
              style: MyText.textStyle(),
              cursorColor: AppColor.primaryColor,
              cursorHeight: 25,
              obscureText: isObscure,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      color: AppColor.primaryColor,
                      icon: Icon(
                          _isObscure ? iconVisibility_off : iconVisibility),
                      onPressed: onPressed
                      ),
                  contentPadding: EdgeInsets.all(8),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xffF2CDD4),
                    ),
                  ),
                  isDense: true, // Added this
                  fillColor: const Color(0xffF2CDD4),
                  labelStyle: MyText.textStyle(color: colorGray)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorMesage() {
    return MyText.baseText(
        text: errorMesage == '' ? '' : '$errorMesage',
        size: 12,
        fontWeight: FontWeight.w600,
        color: primaryColor);
  }

  Widget _submitButton() {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MyText.baseText(
                  text: 'Forgot Password',
                  size: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor),
            ),
          ),
          Container(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                signInWithEmailAndPassword();
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
              child: MyText.baseText(
                  text: 'Log in',
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: colorWhite),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: GestureDetector(
              child: MyText.baseText(
                  text: 'Sign Up',
                  size: 14,
                  fontWeight: FontWeight.w600,
                  color: colorGray),
              onTap: () {
                Navigator.push(context,
                    SwipeablePageRoute(builder: (context) => SignUp()));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget Header() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Center(
        child: Container(
          height: 98,
          width: 98,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(Images.appLogo),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 36,
      ),
      MyText.baseText(
          text: 'Welcome to  Waiter', fontWeight: FontWeight.w400, size: 18),
      const SizedBox(
        height: 6,
      ),
      MyText.baseText(
          text: 'Login to Continue', fontWeight: FontWeight.w400, size: 14),
    ]);
  }

  Widget formLogIn() {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
          bottom: MediaQuery.of(context).size.height * 0.05),
      child: Column(
        children: [
          _entryField(
              title: 'email', isObscure: false, controller: _controllerEmail),
          SizedBox(
            height: 5,
          ),
          _entryField(
            title: 'password',
            isObscure: _isObscure,
            iconVisibility_off: Icons.visibility_off,
            iconVisibility: Icons.visibility,
            controller: _controllerPassword,
            onPressed: () {
              _isObscure = !_isObscure;
              (context as Element).markNeedsBuild();
            },
          ),
          _errorMesage(),
          _submitButton()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
              child: Column(
                children: [
                  Header(),
                  formLogIn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
