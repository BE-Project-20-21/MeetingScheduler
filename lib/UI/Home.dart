import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homeButtons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Authentication App",
      theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.orangeAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.aBeeZeeTextTheme(
            Theme.of(context).textTheme,
          )),
      home: Material(
        child: Container(
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width / 1.5,
                height: height / 4,
                child: Image(
                  image: AssetImage("assets/images/logo1.png"),
                ),
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 2.0,
                  ),
                  //color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              HomeButtons(),
            ],
          )),
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //       Colors.lightBlue,
          //       Colors.blue,
          //       Colors.deepPurpleAccent,
          //     ])),
        ),
      ),
    );
  }
}
