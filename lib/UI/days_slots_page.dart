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
      theme:
          ThemeData(fontFamily: 'Metropolis', dividerColor: Colors.transparent),
      home: Material(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50.0,
                      bottom: 30,
                    ),
                    child: Text(
                      'Select a Day',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 33,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
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
                margin: EdgeInsets.all(20),
                child: DaySelect(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
