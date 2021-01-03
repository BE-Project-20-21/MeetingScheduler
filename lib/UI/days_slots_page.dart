import 'package:authentication_app/Model/dayselector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UI/scheduling_interface.dart';

class DaySlotsPage extends StatefulWidget {
  DaySlotsPage({Key key}) : super(key: key);

  @override
  _DaySlotsPageState createState() => _DaySlotsPageState();
}

class _DaySlotsPageState extends State<DaySlotsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Slots Interface",
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.aBeeZeeTextTheme(
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
              margin: EdgeInsets.all(20),
              child: DaySelect(),
            ),
          ),
        ),
      ),
    );
  }
}
