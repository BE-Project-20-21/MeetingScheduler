import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './userinfo_inputs.dart';

class UserInfoGoogleSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "User Inputs",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.hammersmithOneTextTheme(
            Theme.of(context).textTheme,
          )),
      home: Material(
        child: Container(
          child: SafeArea(
            child: UserInfoInputs(),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF73AEF5),
                Color(0xFF61A4F1),
                Color(0xFF478DE0),
                Color(0xFF398AE5),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
        ),
      ),
    );
  }
}
