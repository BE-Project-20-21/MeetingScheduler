import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './login.dart';

class ForgotPassword extends StatelessWidget {
  //To declare database references
  final FirebaseAuth authForgotPassword = FirebaseAuth.instance;

  //To declare all the variables required for input fields
  String email = "";

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "User Inputs",
      theme:
          ThemeData(fontFamily: 'Metropolis', dividerColor: Colors.transparent),
      home: Material(
        child: Container(
          child: SafeArea(
            child: Container(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Please enter your registered address",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                  Container(
                    height: height / 13,
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      cursorColor: Colors.white,
                      onChanged: (forgotPasswordEmailInput) {
                        email = forgotPasswordEmailInput;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          )),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF614385),
                        // gradient: LinearGradient(
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   colors: [
                        //     Color(0xff5F0A87),
                        //     Color(0xff7a3c68),
                        //   ],
                        // ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      width: width / 3,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {
                          //Call the method to validate and send link to reset password
                          validateAndSendLink(email, context);
                        },
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: Color(0xFF614385),
                            letterSpacing: 1,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30.0,
              ),
            ),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF614385),
                    Color(0xFF516395),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.2, 0.8])),
        ),
      ),
    );
  }

  //To validate the email entered
  void validateAndSendLink(String email, BuildContext context) {
    if (email.isNotEmpty) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (regex.hasMatch(email)) {
        sendLink(email, context);
      } else {
        //To handle the error if the email format is incorrect
        Fluttertoast.showToast(msg: "Please enter a valid email address!");
      }
    } else {
      //To handle the error if the field is empty
      Fluttertoast.showToast(msg: "Please fill all the fields!");
    }
  }

  //To implement the reset password link on the registered email address
  Future<void> sendLink(String email, BuildContext context) async {
    try {
      await authForgotPassword.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
          msg:
              "The link to reset the password has been sent to your registered email address!");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } catch (e) {
      //To handle in case of unknown email address entered
      Fluttertoast.showToast(msg: "Please enter a registered email address");
    }
  }
}
