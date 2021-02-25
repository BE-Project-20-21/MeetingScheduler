import 'package:authentication_app/UI/signup_inputs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Signup",
      theme:
          ThemeData(fontFamily: 'Metropolis', dividerColor: Colors.transparent),
      home: Material(
        child: Container(
          child: SafeArea(
            child: SignupInputs(),
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
}
