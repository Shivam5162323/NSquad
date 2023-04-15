
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {


  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  final _email = TextEditingController();

  final _password = TextEditingController();

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
        hintText: 'email',
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
                                  Text(' Sign in',style: TextStyle(fontSize: 34, color: Colors.white,fontFamily: 'dyna'),),
                                ],
                              )),

                          emailField,

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

                              },
                              child: Text('Sign up'),
                              //     child: loginEmailPasswordButon,
                            ),
                          ),


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
