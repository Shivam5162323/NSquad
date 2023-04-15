import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:nsquad/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authHome.dart';
import 'loginModer.dart';

class SignInScreen extends StatefulWidget {

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscureText = true;

  final _email = TextEditingController();

  final _password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _email,
      autofocus: false,

      validator: (value) {
        if (value != null) {
          if (value.contains('@') && value.endsWith('gmail.com')  ) {
            return null;
          }
          return 'Enter a Valid Email Address';
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail_lock,
          color: Colors.white,
        ),
        hintText: 'mail id',
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


    );










    final passwordField = TextFormField(
      obscureText: _obscureText,
      controller: _password,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        if (value.trim().length < 8) {
          return 'Password must be at least 8 characters in length';
        }
        // Return null if the entered password is valid
        return null;
      },


      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock_open_outlined,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon:
          Icon(_obscureText ? Icons.visibility_off : Icons.visibility,color: Colors.white),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.white70),

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
      ),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),);










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
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,

                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Icon(Icons.login,color: Colors.white,size: 27,),
                                  Text(' Sign in ',style: TextStyle(fontSize: 24,color: Colors.white ,fontWeight: FontWeight.bold,fontFamily: 'Zen'),),
                                ],
                              )),
                          // TextField(
                          //   keyboardType: TextInputType.emailAddress,
                          //   decoration: InputDecoration(
                          //     prefixIcon: Icon(
                          //       Icons.mail_lock,
                          //       color: Colors.white,
                          //     ),
                          //     hintText: 'abc@cuchd.in',
                          //     enabledBorder: UnderlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.white),
                          //     ),
                          //     focusedBorder: UnderlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.cyan),
                          //     ),
                          //   ),
                          //   cursorColor: Colors.white,
                          //   style: TextStyle(color: Colors.white),
                          // ),
                          emailField,
                          // TextField(
                          //   obscureText: true,
                          //   decoration: InputDecoration(
                          //     prefixIcon: Icon(
                          //       Icons.lock_open_outlined,
                          //       color: Colors.white,
                          //     ),
                          //     hintText: 'Password',
                          //     enabledBorder: UnderlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.white),
                          //     ),
                          //     focusedBorder: UnderlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.cyan),
                          //     ),
                          //   ),
                          //   cursorColor: Colors.white,
                          //   style: TextStyle(color: Colors.white),
                          // ),
                          passwordField,
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text('Forgot Password?',style: TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.bold),),

                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {

                                  dynamic result = await _auth.signInEmailPassword(LoginUser(email: _email.text,password: _password.text));
                                  if (result.uid == null) { //null means unsuccessfull authentication
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(result.code),
                                          );
                                        });

                                  }
                                  else{
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString('email', _email.text);
                                    print(_email.text);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePage()));
                                  }
                                }
                              },
                              child: Text('Sign in'),
                              //     child: loginEmailPasswordButon,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 18),
                            child: Row(

                                children: <Widget>[
                                  Expanded(
                                      child: Divider(color: Colors.white,)
                                  ),

                                  Text("  or  ",style: TextStyle(color: Colors.white),),

                                  Expanded(
                                      child: Divider(color: Colors.white,)
                                  ),
                                ]
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('New User?'),
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
                                              SignUpScreen()));
                                },
                                child: Text('Sign up !!',),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
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
