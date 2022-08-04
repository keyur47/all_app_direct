import 'package:all_app_direct/modules/login/controller/log_in_controller.dart';
import 'package:all_app_direct/modules/login/login_controller.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widget/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LogInController logInController = Get.find();

  /// _submitButton
  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF000749), Color(0xFF000749)])),
      // colors: [Color(0xfffbb448), Color(0xfff7892b)])),
      child: GestureDetector(
        onTap: () async {
          await logInController
              .signInUsingEmailPassword(
              email:
              logInController
                  .logInEmail
                  .text
                  .trim(),
              password:
              logInController
                  .logInPassword
                  .text
                  .trim());
        },
        child: const Text(
          'Sign In',
          style: TextStyle(fontSize: 20, color: Color(0xffFFFFFF)),
        ),
      ),
    );
  }

  /// _createAccountLabel
  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigation.popAndPushNamed(Routes.signUpPage);
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: Color(0xFF000749),
                  // color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  /// _title
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'Sign',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xFF000749)),
          children: [
            TextSpan(
              text: ' In',
              style: TextStyle(color: Color(0xFF000749), fontSize: 30),
            ),
            TextSpan(
              text: '',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  /// _emailPasswordWidget
  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email address", "Enter your email",
            logInController.logInEmail),
        _entryField(
            "Password",
            "Enter password",
            isPassword: true,
            logInController.logInPassword),
      ],
    );
  }


  /// _entryField
  Widget _entryField(
      String title, String hinText, TextEditingController TextEditingController,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF000749)),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
            ),
            child: TextFormField(
                controller: TextEditingController,
                obscureText: isPassword,
                decoration: InputDecoration(
                    hintText: hinText,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 15),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: Colors.red, width: 1.5),

                      // borderSide: BorderSide.none
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    // fillColor: Color(0xfff3f3f4),
                    fillColor: const Color(0xffffffff),
                    filled: true)),
          )
        ],
      ),
    );
  }

  /// _facebookButton
  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Image.network(
          //     "https://cdn4.iconfinder.com/data/icons/social-messaging-ui-color-shapes-2/128/social-circle-google-plus-2-512.png",
          //     height: 35),
          // SizedBox(width: 10,),
          // Image.asset("assets/image/facebook-logo-png-2320.png", height: 33),

          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: const Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: const Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }


 // / _divider
  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xffEFEFFF),
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: const BezierContainer()),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      const SizedBox(height: 50),
                      _emailPasswordWidget(),
                      Container(
                        padding: const EdgeInsets.only(top: 3, bottom: 5),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                                     onTap: (){
                                       Navigation.popAndPushNamed(Routes.forgotPassword);
                                     },
                           child: const Text('Forgot Password ?',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ),

                      const SizedBox(height: 50),
                      _submitButton(),
                      _createAccountLabel(),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(vertical: 10),
                      //   alignment: Alignment.centerRight,
                      //   child: const Text('Forgot Password ?',
                      //       style: TextStyle(
                      //           fontSize: 14, fontWeight: FontWeight.w500)),
                      // ),
                      _divider(),
                      _facebookButton(),
                      // SizedBox(height: height * .055),
                    ],
                  ),
                ),
              ),
              // Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ));
  }
}

/// _backButton
// Widget _backButton() {
//   return InkWell(
//     onTap: () {
//       Navigator.pop(context);
//     },
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Row(
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
//             child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
//           ),
//           const Text('Back',
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
//         ],
//       ),
//     ),
//   );
// }

// / _divider
// Widget _divider() {
//   return Container(
//     margin: const EdgeInsets.symmetric(vertical: 10),
//     child: Row(
//       children: const <Widget>[
//         SizedBox(
//           width: 20,
//         ),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: Divider(
//               thickness: 1,
//             ),
//           ),
//         ),
//         Text('or'),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: Divider(
//               thickness: 1,
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 20,
//         ),
//       ],
//     ),
//   );
// }
//
// / _facebookButton
// Widget _facebookButton() {
//   return Container(
//     height: 50,
//     margin: const EdgeInsets.symmetric(vertical: 20),
//     decoration: const BoxDecoration(
//       borderRadius: BorderRadius.all(Radius.circular(10)),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         // Image.network(
//         //     "https://cdn4.iconfinder.com/data/icons/social-messaging-ui-color-shapes-2/128/social-circle-google-plus-2-512.png",
//         //     height: 35),
//         // SizedBox(width: 10,),
//         // Image.asset("assets/image/facebook-logo-png-2320.png", height: 33),
//
//         // Expanded(
//         //   flex: 1,
//         //   child: Container(
//         //     decoration: const BoxDecoration(
//         //       color: Color(0xff1959a9),
//         //       borderRadius: BorderRadius.only(
//         //           bottomLeft: Radius.circular(5),
//         //           topLeft: Radius.circular(5)),
//         //     ),
//         //     alignment: Alignment.center,
//         //     child: const Text('f',
//         //         style: TextStyle(
//         //             color: Colors.white,
//         //             fontSize: 25,
//         //             fontWeight: FontWeight.w400)),
//         //   ),
//         // ),
//         // Expanded(
//         //   flex: 5,
//         //   child: Container(
//         //     decoration: const BoxDecoration(
//         //       color: Color(0xff2872ba),
//         //       borderRadius: BorderRadius.only(
//         //           bottomRight: Radius.circular(5),
//         //           topRight: Radius.circular(5)),
//         //     ),
//         //     alignment: Alignment.center,
//         //     child: const Text('Log in with Facebook',
//         //         style: TextStyle(
//         //             color: Colors.white,
//         //             fontSize: 18,
//         //             fontWeight: FontWeight.w400)),
//         //   ),
//         // ),
//       ],
//     ),
//   );
// }
