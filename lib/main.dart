import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './Components/Authentication/userinfo_google_signin.dart';
import './Components/Authentication/login.dart';
import './Components/Authentication/verify_email.dart';
import './Components/Dashboard/dashboard.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Components/Authentication/biometrics_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  //Declaring database references
  FirebaseAuth authMain = FirebaseAuth.instance;
  LocalAuthentication auth = LocalAuthentication();
  final FirebaseAuth authLogIn = FirebaseAuth.instance;
  bool _isBiometrics;
  Future<void> _checkBiometrics() async {
    bool checkBiometrics;
    try {
      checkBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _isBiometrics = checkBiometrics;
    });
    print("Is biometrics : $_isBiometrics");
  }

  bool fingerAuthValue;
  Future<bool> getBoolFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final fA = prefs.getBool("fA");
    if (fA == null) {
      await prefs.setBool("fA", false);
    }
    return fA;
  }

  Future<bool> _getFingerAuthValue() async {
    final prefs = await SharedPreferences.getInstance();
    bool fingerAuth = await getBoolFromSharedPref();
    setState(() {
      fingerAuthValue = fingerAuth;
    });
    print("favalue  : $fingerAuthValue");
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _getFingerAuthValue();
    _checkBiometrics();
  }

  startTimer() async {
    //Complete navigation handling from Main.dart
    var duration = Duration(seconds: 0);
    //In case no one is logged in
    if (FirebaseAuth.instance.currentUser == null) {
      return Timer(duration, route1);
    } else {
      //Code to get the UID of the current user
      print("ERROR 1");
      final User userMain = authMain.currentUser;
      await userMain.reload();
      String _uidMain = userMain.uid.toString();
      print("UID: $_uidMain");
      String l = userMain.providerData[0].providerId;
      print("Provider: $l");
      if (l == "password") {
        //Check if user email address is verifiied\
        print("status $userMain.emailVerified");
        if (userMain.emailVerified) {
          //Navigate to dashboard
          return Timer(duration, route2);
        } else {
          //Navigate to the email verification page
          return Timer(duration, route4);
        }
      } else {
        //Declaring Database Reference
        FirebaseDatabase databaseMain = new FirebaseDatabase();
        //Checking if user has provided his information
        DatabaseReference referenceMain =
            databaseMain.reference().child("users");
        await referenceMain
            .child(_uidMain)
            .once()
            .then((DataSnapshot datasnapshot) {
          if (datasnapshot.value == null) {
            return Timer(duration, route3);
          } else {
            return Timer(duration, route2);
          }
        });
      }
    }
  }

  route1() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }

  route2() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => (fingerAuthValue & _isBiometrics)
              ? BiometricSetup()
              : Dashboard(),
        ));
  }

  route3() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserInfoGoogleSignIn(),
        ));
  }

  route4() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyEmail(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Authentication App",
      theme:
          ThemeData(fontFamily: 'Metropolis', dividerColor: Colors.transparent),
      home: Material(
        child: Container(
          child: SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image(
                      image: AssetImage("assets/images/logo1.png"),
                    ),
                    margin: EdgeInsets.all(10.0),
                  ),
                  Container(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    margin: EdgeInsets.all(10.0),
                  ),
                  Container(
                    child: Text(
                      "Meeting Scheduler",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            ),
          ),
        ),
      ),
    );
  }
}
