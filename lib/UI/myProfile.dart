import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import '../Model/profiledata.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<ProfileData> profilelist = [];
  String _name;
  String _email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth authMain = FirebaseAuth.instance;
    final User userMain = authMain.currentUser;
    String _uidMain = userMain.uid.toString();
    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child("users");
    dbRef.once().then((DataSnapshot snapshot) {
      var DATA = snapshot.value;

      profilelist.clear();

      ProfileData userdata =
          new ProfileData(DATA[_uidMain]['name'], DATA[_uidMain]['email']);
      profilelist.add(userdata);
      print(profilelist[0].name);
      setState(() {
        _name = profilelist[0].name.toString();
        _email = profilelist[0].email.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double waveheight = 250;
    double datacolumnheight = 325;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.hammersmithOneTextTheme(
              Theme.of(context).textTheme,
            )),
        home: Material(
            child: SafeArea(
          child: Container(
              child: Stack(children: [
                Container(
                  child: ClipShadow(
                      boxShadow: [],
                      clipper: WaveClipperTwo(),
                      child: Container(
                        height: waveheight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF398AE5),
                              Color(0xFF478DE0),
                              Color(0xFF61A4F1),
                              Color(0xFF73AEF5),
                            ],
                            stops: [0.1, 0.4, 0.7, 0.9],
                          ),
                        ),
                      )),
                ),
                Positioned(
                    left: width * 10 / 100,
                    top: waveheight * 65 / 100,
                    child:
                        CircularProfileAvatar('', elevation: 10, radius: 70)),
                Positioned(
                  right: width * 10 / 100,
                  top: waveheight * 70 / 100,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    width: width / 4,
                    child: RaisedButton(
                      elevation: 10.0,
                      onPressed: () {},
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        'FOLLOW',
                        style: TextStyle(
                          color: Color(0xFF527DAA),
                          letterSpacing: 1,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: height - 100,
                  right: width * 10 / 100,
                  child: FloatingActionButton(
                    onPressed: () {},
                    elevation: 10,
                    backgroundColor: Color(0xFF398AE5),
                    child: Icon(
                      Icons.edit,
                      size: 25,
                    ),
                  ),
                ),
                Positioned(
                  left: width * 10 / 100,
                  top: datacolumnheight,
                  child: _name == null
                      ? CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.blue),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                _name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                _email,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                )
              ]),
              color: Colors.white),
        )));
  }
}
