import '../main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignupInputs extends StatelessWidget {
  //Declaring Database references
  final FirebaseAuth authSignUp = FirebaseAuth.instance;

  //Creating an object of ProgressDialog
  ProgressDialog progressDialog;

  //The variables required to save the inputs
  String fullname = "";
  String username = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String contact = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return SingleChildScrollView(
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
                  "Please enter your details",
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
                onChanged: (fullnameInput) {
                  fullname = fullnameInput;
                },
                keyboardType: TextInputType.name,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    )),
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
            Container(
              height: height / 13,
              alignment: Alignment.centerLeft,
              child: TextField(
                onChanged: (usernameInputs) {
                  username = usernameInputs;
                },
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.account_box,
                      color: Colors.white,
                    )),
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
            Container(
              height: height / 13,
              alignment: Alignment.centerLeft,
              child: TextField(
                onChanged: (contactInput) {
                  contact = contactInput;
                },
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    hintText: "Contact",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.white,
                    )),
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
                  hintText: "Email",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
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
            Container(
              height: height / 13,
              alignment: Alignment.centerLeft,
              child: TextField(
                onChanged: (passwordInput) {
                  password = passwordInput;
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
                obscureText: true,
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
            Container(
              height: height / 13,
              alignment: Alignment.centerLeft,
              child: TextField(
                onChanged: (confirmPasswordInput) {
                  confirmPassword = confirmPasswordInput;
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
                obscureText: true,
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
                    //Call the method to validate the inputs and then signup the user
                    validateAndSignup(fullname, username, contact, email,
                        password, confirmPassword, context);
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Text(
                    'SIGN UP',
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
              height: height / 30,
            ),
          ],
        ),
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 30.0,
        ),
      ),
    );
  }

  //Method to validate the function (Nested Validation)
  void validateAndSignup(
      String fullname,
      String username,
      String contact,
      String email,
      String password,
      String confirmPassword,
      BuildContext context) {
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

    //Handling the inputs
    //To check that no field is empty
    if (fullname.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        username.isNotEmpty &&
        contact.isNotEmpty) {
      //To check with the database if the username is unique (pending)

      //Pattern matching for the email
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (regex.hasMatch(email)) {
        if (password == confirmPassword) {
          signUpWithEmailandPassword(fullname, username, contact, email,
              password, confirmPassword, context);
        } else {
          //Handle error for non matching passwords
          Fluttertoast.showToast(
              msg: "The passwords you have entered do not match!");
        }
      } else {
        //Handle error for incorrect email format
        Fluttertoast.showToast(msg: "Please enter a valid email address!");
      }
    } else {
      //Handle error if any field is empty
      Fluttertoast.showToast(msg: "Please fill all the fields!");
    }
  }

  //Method to Create account and add user data into the databse as well
  void signUpWithEmailandPassword(
      String fullname,
      String username,
      String contact,
      String email,
      String password,
      String confirmPassword,
      BuildContext context) async {
    //Creating account using inbuilt function
    try {
      await authSignUp.createUserWithEmailAndPassword(
          email: email, password: password);
      try {
        //Send email verification mail
        User userSignUp = authSignUp.currentUser;
        await userSignUp.sendEmailVerification().then((value) {
          addDataToDatabase(fullname, username, contact, email, context);
        });
      } catch (e1) {
        Fluttertoast.showToast(msg: "Some unknown error has occured");
      }
      // //To add the User information to the databse and then navigate
      // addDataToDatabase(fullname, email, context);
    } catch (e) {
      //Handle Exceptions
      Fluttertoast.showToast(msg: "Some unknown error has occured");
    }
  }

  void addDataToDatabase(String fullname, String username, String contact,
      String email, BuildContext context) async {
    try {
      //Declaring Database references
      FirebaseDatabase databaseSignUp = new FirebaseDatabase();
      DatabaseReference referenceSignUp =
          databaseSignUp.reference().child("users");
      //To get the UID of the newly added user
      final User userSignUp = authSignUp.currentUser;
      final String uid = userSignUp.uid.toString();
      //To add the inputs into the database
      referenceSignUp.child(uid).set({
        "name": fullname,
        "username": username,
        "contact": contact,
        "email": email
      });

      //Code to add the username to the lists of usernames
      DatabaseReference referenceUsername =
          databaseSignUp.reference().child("usernames");
      await referenceUsername.child(username).set({"name": fullname});

      Fluttertoast.showToast(
          msg:
              "Account created Successfully, Please verify the email address and login again!");

      //Code to logout and navigate back to login page
      await authSignUp.signOut();
      progressDialog.hide();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));
    } catch (e) {
      //To handle errors
      Fluttertoast.showToast(msg: "Some unknown error has occured!");
    }
  }
}
