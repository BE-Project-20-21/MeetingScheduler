import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double height2 = 250;
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
                        height: height2,
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
                    top: height2 * 65 / 100,
                    child:
                        CircularProfileAvatar('', elevation: 10, radius: 70)),
                Positioned(
                  right: width * 10 / 100,
                  top: height2 * 70 / 100,
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
              ]),
              color: Colors.white),
        )));
  }
}
