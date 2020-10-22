import 'package:authentication_app/UI/dashboard.dart';
import 'package:authentication_app/UI/forgot_pasword.dart';
import 'package:authentication_app/UI/userinfo_google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Model/FadeAnimation.dart';
import '../UI/signup.dart';

class Login extends StatelessWidget {
  //Declaring Database references
  final FirebaseAuth authLogIn = FirebaseAuth.instance;
  //Creating an object of ProgressDialog
  ProgressDialog progressDialog;

  //To declare the variables required for the inputs
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Firebase.initializeApp();
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.hammersmithOneTextTheme(
            Theme.of(context).textTheme,
          )),
      home: Material(
        child: Container(
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
          child: SafeArea(
            child: Container(
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    width: 50,
                    height: 80,
                    child: FadeAnimation(
                        1.5,
                        Container(
                          child: Image(
                            image: AssetImage("assets/images/clock.png"),
                          ),
                        )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "MS",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 40,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      Container(
                        height: height / 13,
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          onChanged: (emailInput) {
                            email = emailInput;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF6CA8F1),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      Container(
                        height: height / 13,
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          onChanged: (passwordInput) {
                            password = passwordInput;
                          },
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF6CA8F1),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height / 60,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Container(
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 5.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 60,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          width: width / 3,
                          child: RaisedButton(
                            elevation: 5.0,
                            onPressed: () {
                              validateAndLogin(email, password, context);
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: Text(
                              'LOG IN',
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
                      SizedBox(
                        height: height / 60,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          width: width / 2.9,
                          child: RaisedButton(
                            elevation: 5.0,
                            onPressed: () {
                              //Code to Carry on google Signin
                              //Call the method to carry on google signin
                              signInWithGoogle(context);
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                  image: AssetImage("assets/images/google.png"),
                                  height: 25,
                                ),
                                Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                    color: Color(0xFF527DAA),
                                    letterSpacing: 1,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 60,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.all(16.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Don\'t have an Account? ',
                                      style: GoogleFonts.hammersmithOne(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: GoogleFonts.hammersmithOne(
                                        textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Method to validate the inputs
  void validateAndLogin(String email, String password, BuildContext context) {
    if (email.isNotEmpty && password.isNotEmpty) {
      //Pattern matching for the email
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (regex.hasMatch(email)) {
        if (password.length >= 6) {
          signinWithEmailAndPassword(email, password, context);
        } else {
          //To handle insufficient password length
          Fluttertoast.showToast(
              msg: "Password length should be more than 6 characters!");
        }
      } else {
        //To handle the incorrect email format
        Fluttertoast.showToast(msg: "Please enter a valid email address!");
      }
    } else {
      //Handling the error if fields are empty
      Fluttertoast.showToast(msg: "Please fill all the fields!");
    }
  }

  void signinWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    //Creating account using inbuilt function
    try {
      await authLogIn.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } catch (e) {
      //Handle Exceptions
      print(e);
      Fluttertoast.showToast(msg: "Incorrect Password!");
    }
  }

  //Method to implement Google Signin
  void signInWithGoogle(BuildContext context) async {
    //Code to implement google signin
    final googleSignIn = GoogleSignIn();
    //Code to provide interface to choose the google account to SignIn
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    //After choosing the account
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserCredential result =
          await authLogIn.signInWithCredential(authCredential);

      //Adding user to authentication is complete, now we need to handle the navigation based on whether the user has provided the personal details
      //Code to show the progres bar (UI BASED)
      progressDialog = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      progressDialog.style(
        child: Container(
          color: Colors.white,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightBlue),
          ),
          margin: EdgeInsets.all(10.0),
        ),
        message: "Checking Information..",
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        elevation: 40.0,
        progress: 0.0,
        maxProgress: 100.0,
        insetAnimCurve: Curves.easeInOut,
        progressWidgetAlignment: Alignment.center,
        progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0),
        messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0),
      );
      progressDialog.show();

      //Code to fetch the UID of the newly authenticated user
      final User userLogIn = authLogIn.currentUser;
      final String uid = userLogIn.uid.toString();

      //Calling the function to handle the navigation
      navigateSignUp(uid, context);
    }
  }

  //Method to handle navigation for google Signin
  void navigateSignUp(String uid, BuildContext context) async {
    //Declaring the database reference to the node in "users" node
    FirebaseDatabase databaseLookUp = new FirebaseDatabase();
    DatabaseReference referenceLookUp =
        databaseLookUp.reference().child("users");
    await referenceLookUp.child(uid).once().then((DataSnapshot datasnapshot) {
      if (datasnapshot.value == null) {
        progressDialog.hide();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => UserInfoGoogleSignIn()));
      } else {
        progressDialog.hide();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
    });
  }
}
