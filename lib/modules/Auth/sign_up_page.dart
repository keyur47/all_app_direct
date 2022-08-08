
import 'package:all_app_direct/modules/Auth/controller/sign_up_controller.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/Clipper/bezierContainer.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key ?key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  SignUpController signUpController = Get.find();


  /// _submitButton
  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff000749), Color(0xff000749)])),
      child: GestureDetector(
        onTap: () async {
          await signUpController
              .registerUsingEmailPassword(
            name: signUpController
                .signUpName.text,
            contact: signUpController
                .signUpContactNo.text,
            email: signUpController
                .signUpEmail.text
                .trim(),
            password: signUpController
                .signUpPassword.text
                .trim(),
          );
        },
         child: const Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }


  /// _backButton
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigation.popAndPushNamed(Routes.loginPage);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }


  ///_loginAccountLabel
  Widget _loginAccountLabel() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  <Widget>[
          const Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigation.popAndPushNamed(Routes.loginPage);
            },
            child: const Text(
              'Sign In',
              style: TextStyle(
                  color: Color(0xff000749),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }


  ///_title
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'Sign',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xff000749)
          ),

          children: [
            TextSpan(
              text: ' Up',
              style: TextStyle(color: Color(0xff000749), fontSize: 30),
            ),
            TextSpan(
              text: '',
              style: TextStyle(color: Color(0xff000749), fontSize: 30),
            ),
          ]),
    );
  }

  ///_emailPasswordWidget
  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Name address","Enter your name",signUpController.signUpName),
        _entryField("Email address","Enter your email",signUpController.signUpEmail),
        _entryField("Contacts no.", "Enter your Contacts",signUpController.signUpContactNo,isPassword: true,),
        _entryField("Password","Enter password",signUpController.signUpPassword),
      ],
    );
  }

  /// _entryField
  Widget _entryField(String title, hinText,TextEditingController?  TextEditingController,{bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Color(0xff000749)),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
            ),
            child: TextField(
                controller: TextEditingController,
                obscureText: isPassword,
                decoration:  InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 14,horizontal: 15),
                    border: InputBorder.none,
                    hintText: hinText,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                      // borderSide: BorderSide.none
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    ),
                    fillColor: Color(0xffFFFFFF),
                    filled: true)),
          )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffEFEFFF),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    const SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    // SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
