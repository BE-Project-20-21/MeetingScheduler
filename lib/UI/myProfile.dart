import 'package:flutter/material.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      var data = snapshot.value;

      profilelist.clear();

      ProfileData userdata =
          new ProfileData(data[_uidMain]['name'], data[_uidMain]['email']);
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
            fontFamily: 'Metropolis', dividerColor: Colors.transparent),
        home: Material(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF614385),
                    Color(0xFF516395),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.2, 0.8])),
          child: SafeArea(
            child: Container(
                child: Stack(children: [
                  Container(
                    color: Color(0xff3d2f4f),
                    child: ClipShadow(
                        boxShadow: [],
                        clipper: WaveClipperTwo(),
                        child: Container(
                          height: waveheight,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF614385),
                                    Color(0xFF516395),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.2, 0.8])),
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
                            color: Color(0xFF614385),
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
                      backgroundColor: Color(0xFF614385),
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
                                    color: Colors.white,
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
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  )
                ]),
                color: Color(0xff3d2f4f)),
          ),
        )));
  }
}
