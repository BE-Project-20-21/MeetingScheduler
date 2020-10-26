import 'package:authentication_app/UI/dashboard.dart';
import 'package:authentication_app/UI/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login.dart';

class HomeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Signup()));
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Icon(
                    FontAwesomeIcons.userPlus,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Text(
                    "SIGN UP!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  spreadRadius: 1.0,
                  blurRadius: 2.0,
                  offset: Offset(
                    3.0,
                    3.0,
                  ),
                ),
              ],
            ),
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 28.0,
              vertical: 10.0,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            //Check if already logged in
            if (FirebaseAuth.instance.currentUser != null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            } else {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Icon(
                    FontAwesomeIcons.signInAlt,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Text(
                    "LOG IN!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  spreadRadius: 1.0,
                  blurRadius: 2.0,
                  offset: Offset(
                    3.0,
                    3.0,
                  ),
                ),
              ],
            ),
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 28.0,
              vertical: 10.0,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            //Handle navigation for google signin
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Icon(
                    FontAwesomeIcons.google,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Text(
                    "SIGN-IN!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  spreadRadius: 1.0,
                  blurRadius: 2.0,
                  offset: Offset(
                    3.0,
                    3.0,
                  ),
                ),
              ],
            ),
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 28.0,
              vertical: 10.0,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
