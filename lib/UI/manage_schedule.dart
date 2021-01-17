import 'package:authentication_app/Model/time_slots.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';
import './timeSlotpicker.dart';

//Saving the context of manage_schedule.dart page
BuildContext globalContextManageSchedule;

class ManageSchedule extends StatefulWidget {
  @override
  _ManageScheduleState createState() => _ManageScheduleState();
}

class _ManageScheduleState extends State<ManageSchedule> {
  DateTime startTime;
  DateTime endTime;
  var pickedDate = new DateTime.now();
  var dateUtility = new DateUtil();
  @override
  void initState() {
    startTime = null;
    endTime = null;
    super.initState();
  }

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    globalContextManageSchedule = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Manage Schedule",
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
                    padding: const EdgeInsets.only(top: 50.0, bottom: 30),
                    child: Text(
                      'My Schedule',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 30,
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ExpansionTile(
                          maintainState: true,
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          title: Row(
                            children: [
                              Text(
                                  "${newDates(0).day}/${newDates(0).month}/${newDates(0).year}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                              SizedBox(
                                width: 20,
                              ),
                              Text("${DateFormat('EEEE').format(newDates(0))}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(pickedDate)
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          maintainState: true,
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          title: Row(
                            children: [
                              Text(
                                "${newDates(1).day}/${newDates(1).month}/${newDates(1).year}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(1))}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(1))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          maintainState: true,
                          title: Row(
                            children: [
                              Text(
                                "${newDates(2).day}/${newDates(2).month}/${newDates(2).year}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(2))}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(2))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          maintainState: true,
                          title: Row(
                            children: [
                              Text(
                                "${newDates(3).day}/${newDates(3).month}/${newDates(3).year}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(3))}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(3))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          maintainState: true,
                          title: Row(
                            children: [
                              Text(
                                "${newDates(4).day}/${newDates(4).month}/${newDates(4).year}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(4))}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(4))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          maintainState: true,
                          title: Row(
                            children: [
                              Text(
                                "${newDates(5).day}/${newDates(5).month}/${newDates(5).year}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(5))}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(5))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          maintainState: true,
                          title: Row(
                            children: [
                              Text(
                                "${newDates(6).day}/${newDates(6).month}/${newDates(6).year}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(6))}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(6))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Container(
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () {
                                submit();
                              },
                              padding: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Colors.white,
                              child: Text(
                                "Submit Schedule",
                                style: TextStyle(
                                  color: Color(0xFF398AE5),
                                  letterSpacing: 1,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime newDates(int i) {
    var newDate = Jiffy(pickedDate).add(days: i);
    return newDate;
  }

  //Method to trigger methods on time_slots.dart file to validate and submit the entire schedule
  void submit() {
    TimeSlots(null, null, true);
  }
}
