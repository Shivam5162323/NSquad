// import 'dart:convert';
// import 'dart:math';
//
// import 'package:email_auth/email_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server/gmail.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:crypto/crypto.dart';
//
// import 'authhome.dart';
// // import 'homepage.dart';
// import 'loginmoder.dart';
//
//
//
//
//
//
// // String _generateVerificationCode() {
// //   final bytes = utf8.encode(DateTime.now().toIso8601String());
// //   final hash = sha256.convert(bytes);
// //   return hash.toString().substring(0, 6);
// // }
//
//
//
//
//
//
//
// class SignUpScreen extends StatefulWidget {
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final AuthService _auth = AuthService();
//
//   // bool _obscureText = true;
//   final _email = TextEditingController();
//   final _password = TextEditingController();
//   final _name = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final registerbutton = ElevatedButton(
//       onPressed: () async {
//         if (_formKey.currentState!.validate()) {
//           dynamic result = await _auth.registerEmailPassword(
//               LoginUser(email: _email.text, password: _password.text));
//           if (result.uid ==null) {
//             //null means unsuccessfull authentication
//             showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     content: Text(result.code),
//                   );
//                 });
//           }
//           else{
//             // SharedPreferences prefs = await SharedPreferences.getInstance();
//             // prefs.setString('email', _email.text);
//             // print(_email.text);
//
//
//             // sendOTP(_email.text);
//             // Navigator.pushReplacement(
//             //     context,
//             //     MaterialPageRoute(
//             //         builder: (context) =>
//             //             OTPScreen(_email.text)));
//           }
//         }
//       },
//       child: Text('Sign up'),
//     );
//
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/images/cactus.jpg'), fit: BoxFit.cover),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ClipRRect(
//                 // borderRadius: BorderRadius.circular(45),
//                 child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 35),
//                     padding: EdgeInsets.only(
//                         left: 18, right: 18, bottom: 18, top: 8),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         color: Colors.black54),
//                     // color: Colors.white,
//                     // color: Colors.black54,
//                     child: Form(
//                       autovalidateMode: AutovalidateMode.always,
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           Container(
//                               margin: EdgeInsets.only(bottom: 24),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     CupertinoIcons.person_add,
//                                     color: Colors.white,
//                                     size: 27,
//                                   ),
//                                   Text(
//                                     ' Sign up ',
//                                     style: TextStyle(
//                                         fontSize: 24,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Zen'),
//                                   ),
//                                 ],
//                               )),
//                           TextFormField(
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'Name is required!';
//                               }
//
//                               return null;
//                             } ,
//                             textCapitalization: TextCapitalization.words,
//                             controller: _name,
//                             keyboardType: TextInputType.name,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(
//                                 Icons.person,
//                                 color: Colors.white,
//                               ),
//                               hintText: 'Name',
//                               hintStyle: TextStyle(color: Colors.white70),
//
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.cyan),
//                               ),
//                             ),
//                             cursorColor: Colors.white,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           TextFormField(
//                             controller: _email,
//                             keyboardType: TextInputType.emailAddress,
//                             validator: (value) {
//                               if (value != null) {
//                                 if (value.contains('@') && value.endsWith('cuchd.in')) {
//                                   return null;
//                                 }
//                                 return 'Enter a Valid CU mail';
//                               }
//                             },
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(
//                                 Icons.mail_lock,
//                                 color: Colors.white,
//                               ),
//                               hintText: 'CU mail id',
//                               hintStyle: TextStyle(color: Colors.white70),
//
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.cyan),
//                               ),
//                             ),
//                             cursorColor: Colors.white,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           TextFormField(
//                             controller: _password,
//                             obscureText: true,
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'This field is required';
//                               }
//                               if (value.trim().length < 8) {
//                                 return 'Password must be at least 8 characters in length';
//                               }
//                               // Return null if the entered password is valid
//                               return null;
//                             } ,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(
//                                 Icons.lock_open_outlined,
//                                 color: Colors.white,
//                               ),
//                               hintText: 'Enter a password',
//                               hintStyle: TextStyle(color: Colors.white70),
//
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.cyan),
//                               ),
//                             ),
//                             cursorColor: Colors.white,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(top: 18),
//                             child: SizedBox(
//                               width: double.infinity,
//                               child: registerbutton,
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.symmetric(vertical: 18),
//                             child: Row(children: <Widget>[
//                               Expanded(
//                                   child: Divider(
//                                     color: Colors.white,
//                                   )),
//                               Text("  or  "),
//                               Expanded(
//                                   child: Divider(
//                                     color: Colors.white,
//                                   )),
//                             ]),
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Already have a account ?'),
//                           ),
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               SignInScreen()));
//                                 },
//                                 child: Text(
//                                   'Sign in !!',
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   shape: RoundedRectangleBorder(
//                                       side: BorderSide(color: Colors.white)),
//                                   backgroundColor: Colors.black87,
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'dart:math';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
// import 'package:news/otp.dart';
import 'signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:crypto/crypto.dart';

import 'authHome.dart';

import 'loginModer.dart';






// String _generateVerificationCode() {
//   final bytes = utf8.encode(DateTime.now().toIso8601String());
//   final hash = sha256.convert(bytes);
//   return hash.toString().substring(0, 6);
// }







class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _auth = AuthService();

  // bool _obscureText = true;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    final registerbutton = ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          dynamic result = await _auth.registerEmailPassword(
              LoginUser(email: _email.text, password: _password.text));
          if (result.uid ==null) {
            //null means unsuccessfull authentication
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(result.code),
                  );
                });
          }
          else{
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.setString('email', _email.text);
            // print(_email.text);


            // sendOTP(_email.text);
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             OTPScreen(_email.text)));
          }
        }
      },
      child: Text('Sign up'),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/signindog.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.circular(45),
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 35),
                    padding: EdgeInsets.only(
                        left: 18, right: 18, bottom: 18, top: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black54),
                    // color: Colors.white,
                    // color: Colors.black54,
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.person_add,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                  Text(
                                    ' Sign up ',
                                    style: TextStyle(
                                      color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Zen'),
                                  ),
                                ],
                              )),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Name is required!';
                              }

                              return null;
                            } ,
                            textCapitalization: TextCapitalization.words,
                            controller: _name,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintText: 'Name',
                              hintStyle: TextStyle(color: Colors.white70),

                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              ),
                            ),
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                          ),
                          TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value != null) {
                                if (value.contains('@') && value.endsWith('gmail.com')) {
                                  return null;
                                }
                                return 'Enter a valid mail';
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.mail_lock,
                                color: Colors.white,
                              ),
                              hintText: 'Mail id',
                              hintStyle: TextStyle(color: Colors.white70),

                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              ),
                            ),
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                          ),
                          TextFormField(
                            controller: _password,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'This field is required';
                              }
                              if (value.trim().length < 8) {
                                return 'Password must be at least 8 characters in length';
                              }
                              // Return null if the entered password is valid
                              return null;
                            } ,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_open_outlined,
                                color: Colors.white,
                              ),
                              hintText: 'Enter a password',
                              hintStyle: TextStyle(color: Colors.white70),

                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              ),
                            ),
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18),
                            child: SizedBox(
                              width: double.infinity,
                              child: registerbutton,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 18),
                            child: Row(children: <Widget>[
                              Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                  )),
                              Text("  or  ",style: TextStyle(color: Colors.white),),
                              Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                  )),
                            ]),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Already have a account ?'),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignInScreen()));
                                },
                                child: Text(
                                  'Sign in !!',
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.white)),
                                  backgroundColor: Colors.black87,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
