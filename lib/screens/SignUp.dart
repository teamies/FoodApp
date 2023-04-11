import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/mytext.dart';
import '../constants/constants.dart';
import '../core/_config.dart';
import '../models/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? errorMesage = '';
  static bool _noObscure = false;
  static bool _isObscurePassword = true;
  static bool _isObscureConfirmPassword = true;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    if (_controllerConfirmPassword.text == _controllerPassword.text) {
      try {
        await Auth().createUserWithEmailAndPassword(
            email: _controllerEmail.text, password: _controllerPassword.text);
        await Auth().savingUserData(
            name: _controllerName.text,
            password: _controllerPassword.text,
            ConfirmPassword: _controllerConfirmPassword.text,
            email: _controllerEmail.text);
        Navigator.pushNamedAndRemoveUntil(context, '/LogIn', (route) => false);
        print('------------------------------ok------------------------');
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMesage = e.message;
          print('================' + e.toString());
          print('-------------------false-------------------');
        });
      }
    } else {
      print('false');
      setState(() {
        errorMesage = 'Confirm the password does not match the password';
      });
    }
  }

  Widget _errorMesage() {
    return Container(
      width: double.infinity,
      child: Center(
        child: MyText.baseText(
            text: errorMesage == '' ? '' : '$errorMesage',
            size: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor),
      ),
    );
  }

  bool checkPass = true;

  void _checkPasswordMatch() {
    if (_controllerPassword.text == _controllerConfirmPassword.text ||
        _controllerConfirmPassword.text == null &&
            _controllerPassword.text == null) {
      setState(() {
        checkPass = true;
      });
    } else {
      setState(() {
        checkPass = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          // height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(height: 30),
              Header(),
              formSignUp(),
              _errorMesage()
            ],
          ),
        ),
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
      Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
        width: MediaQuery.of(context).size.width / 2,
        child: MyText.baseText(
            text: 'WELCOME', size: 40, maxLine: 1, fontWeight: FontWeight.w700),
      )
    ]);
  }

  Widget formSignUp() {
    return Container(
      // height: double.infinity*2/3,
      // height: MediaQuery.of(context).size.height * 4 / 5,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _entryField(
              title: 'Name',
              isObscure: true,
              controller: _controllerName,
              color:  Color(0xffF2CDD4)),
          const SizedBox(
            height: 5,
          ),
          _entryField(
              title: 'Email',
              isObscure: _noObscure,
              controller: _controllerEmail,
              color:  Color(0xffF2CDD4)),
          const SizedBox(
            height: 5,
          ),
          _entryField(
              title: 'Password',
              isObscure: true,
              iconVisibility_off: Icons.visibility_off,
              iconVisibility: Icons.visibility,
              controller: _controllerPassword,
              color: checkPass ?  Color(0xffF2CDD4): AppColor.primaryColor),
          const SizedBox(
            height: 5,
          ),
          _entryField(
              title: 'Confirm Password',
              isObscure: false,
              iconVisibility_off: Icons.visibility_off,
              iconVisibility: Icons.visibility,
              controller: _controllerConfirmPassword,
              color: checkPass ?  Color(0xffF2CDD4): AppColor.primaryColor),
          _submitButton()
        ],
      ),
    );
  }

  Widget _entryField({
    required String title,
    IconData? iconVisibility_off,
    IconData? iconVisibility,
    Function? onChanged,
    required bool isObscure,
    required Color color,
    TextEditingController? controller,
  }) {
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
              onChanged: (value) {
                _checkPasswordMatch();
              },
              controller: controller,
              style: MyText.textStyle(),
              cursorColor: AppColor.primaryColor,
              cursorHeight: 25,
              // obscureText: isObscure,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    color: AppColor.primaryColor,
                    icon: Icon(isObscure ? iconVisibility_off : iconVisibility),
                    onPressed: () {
                      print('object');
                      
                      print(isObscure);
                      // isObscure = !isObscure;
                      // print(isObscure);
                      // (context as Element).markNeedsBuild();
                      setState(() {
                        isObscure = !isObscure;
                        // isObscure ? iconVisibility_off : iconVisibility;
                      });
                       print(isObscure);
                    },
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
                    borderSide: BorderSide(
                      width: 1,
                      color: color,
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

  Widget _submitButton() {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                createUserWithEmailAndPassword();
              },
              child: MyText.baseText(
                  text: 'Sign up',
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: colorWhite),
              style: TextButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText.baseText(
                  text: 'Already have account?',
                  size: 14,
                  fontWeight: FontWeight.w600,
                  color: colorGray),
              GestureDetector(
                child: MyText.baseText(
                  text: 'Sign in',
                  size: 14,
                  fontWeight: FontWeight.w600,
                ),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/LogIn", (r) => false);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}



