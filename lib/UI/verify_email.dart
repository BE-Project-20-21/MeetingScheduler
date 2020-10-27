import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyEmail extends StatelessWidget {
  //To declare firebase authentication variables
  final FirebaseAuth authVerification = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            child: SingleChildScrollView(
              child: Container(
                height: height,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      "Please verify your email address using the link sent to you!",
                                  style: GoogleFonts.hammersmithOne(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
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
                            //Call the method to resend the link for email address verification
                            sendLink(context);
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            'Resend Link',
                            style: TextStyle(
                              color: Color(0xFF527DAA),
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
              ),
            ),
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

  sendLink(BuildContext context) async {
    //To get the current logged in user
    User _userVerification = authVerification.currentUser;
    String _uidVerifivation = _userVerification.uid.toString();
    Fluttertoast.showToast(msg: "UID: $_uidVerifivation");
    await _userVerification.sendEmailVerification().then((value) =>
        Fluttertoast.showToast(
            msg:
                "Email Verification link has been sent to you. Please verify and restart the application to enter the system!"));
  }
}
