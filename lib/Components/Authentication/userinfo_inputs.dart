import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './login.dart';
import '../Dashboard/dashboard.dart';

class UserInfoInputs extends StatelessWidget {
  //Declaring the variables to store the user input
  String gfullname = "";
  String gcontact = "";
  String gusername = "";
  String gemail = "";

  //Declaring database instances
  final FirebaseAuth authUserInfo = FirebaseAuth.instance;

  //Creating an object of ProgressDialog
  ProgressDialog progressDialog;
  //Declaring variable required to save the email of signed in user
  final User userEmail = FirebaseAuth.instance.currentUser;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  //Code to render the UI
  @override
  Widget build(BuildContext context) {
    String emailUsed = userEmail.providerData[0].email;
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Firebase.initializeApp();
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
                onChanged: (gfullnameInput) {
                  gfullname = gfullnameInput;
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
                onChanged: (gusernameInput) {
                  gusername = gusernameInput;
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
                onChanged: (gcontactInput) {
                  gcontact = gcontactInput;
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
                onChanged: (gemailInput) {
                  gemail = gemailInput;
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
                    //Call the method to validate the inputs and enter the user inputs into database
                    validateAndGSignUp(
                        gfullname, gusername, gcontact, gemail, context);
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Text(
                    'SUBMIT',
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
            GestureDetector(
              onTap: () async {
                //Code to logout of the app
                await googleSignIn.signOut();
                await FirebaseAuth.instance.signOut();
                Fluttertoast.showToast(msg: "Logging Out!");
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Signed in as $emailUsed",
                            style: GoogleFonts.hammersmithOne(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                        TextSpan(
                          text: '\nLog Out?',
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

  //Method to validate user inputs
  validateAndGSignUp(String gfullname, String gusername, String gcontact,
      String gemail, BuildContext context) {
    //Code to check if no input is empty
    if (gfullname.isNotEmpty &&
        gemail.isNotEmpty &&
        gusername.isNotEmpty &&
        gcontact.isNotEmpty) {
      //Code to check if username is unique
      FirebaseDatabase checkUsername = new FirebaseDatabase();
      DatabaseReference checkUsernameReferenece =
          checkUsername.reference().child("usernames");
      checkUsernameReferenece
          .child(gusername)
          .once()
          .then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.value != null) {
          Fluttertoast.showToast(msg: "The username is not available.");
        } else {
          //Code to validate the email
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (regex.hasMatch(gemail)) {
            //Check the length of contact number
            if (gcontact.length == 10) {
              //Code to add data to the database
              addUserInfoToDatabase(
                  gfullname, gusername, gcontact, gemail, context);
            } else {
              Fluttertoast.showToast(
                  msg: "Please enter a valid contact number");
            }
          } else {
            Fluttertoast.showToast(msg: "Please enter a valid email address!");
          }
        }
      });
    } else {
      //Handle error if any field is empty
      Fluttertoast.showToast(msg: "Please fill all the fields!");
    }
  }

  //Method to add User information to the database
  addUserInfoToDatabase(String gfullname, String gusername, String gcontact,
      String gemail, BuildContext context) async {
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
      message: "Creating Account!",
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

    //Code to navigate to the Dashboard after creating and entering all the user data into the database
    //Declaring Database Reference
    FirebaseDatabase databaseUserInfo = new FirebaseDatabase();
    DatabaseReference referenceUserInfo =
        databaseUserInfo.reference().child("users");
    //Code to get the uid of the current user
    final User userGSignin = authUserInfo.currentUser;
    String _uidUserInfo = userGSignin.uid.toString();
    //Code to push the data into database
    await referenceUserInfo.child(_uidUserInfo).set({
      "name": gfullname,
      "username": gusername,
      "contact": gcontact,
      "email": gemail,
    });

    //Code to add the username to the lists of usernames
    DatabaseReference referenceUsername =
        databaseUserInfo.reference().child("usernames");
    await referenceUsername.child(gusername).set({"name": gfullname});

    //Code to add name to firestore to perform searching
    String searchKey = gfullname.substring(0, 1);
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("names")
        .doc(_uidUserInfo)
        .set({"name": gfullname, "searchKey": searchKey, "uid": _uidUserInfo});

    //Code to Enter the device token into the firebase database
    //Code to get the uid of the current user
    String uidToken = authUserInfo.currentUser.uid.toString();
    FirebaseMessaging fcmToken = new FirebaseMessaging();
    String tokenID = await fcmToken.getToken();
    String platform;
    if (Platform.isAndroid) {
      platform = "Android";
    } else {
      platform = "IOS";
    }
    FirebaseDatabase databaseToken = new FirebaseDatabase();
    DatabaseReference referenceToken = databaseToken.reference().child("token");
    await referenceToken
        .child(uidToken)
        .set({"tokenId": tokenID, "platform": platform})
        .then((value) => progressDialog.hide())
        .then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard())));
  }
}
