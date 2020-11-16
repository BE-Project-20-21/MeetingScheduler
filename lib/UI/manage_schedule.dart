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
      theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.orangeAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.aBeeZeeTextTheme(
            Theme.of(context).textTheme,
          )),
      home: Material(
        child: SingleChildScrollView(
          child: Container(
            child: SafeArea(
                child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: Text("Prepare your schedule...",
                        style: GoogleFonts.aBeeZee(
                          textStyle:
                              TextStyle(color: Colors.deepOrange, fontSize: 30),
                        )),
                  ),
                  ExpansionTile(
                    maintainState: true,
                    title: Text(
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}" +
                          "   " +
                          "${DateFormat('EEEE').format(pickedDate)}",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 20)),
                    ),
                    children: <Widget>[
                      TimeSlotPickerMatrix(
                          DateFormat('EEEE').format(pickedDate).toString())
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    maintainState: true,
                    title: Text(
                      "${newDates(1).day}/${newDates(1).month}/${newDates(1).year}" +
                          "   " +
                          "${DateFormat('EEEE').format(newDates(1))}",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 20)),
                    ),
                    children: <Widget>[
                      TimeSlotPickerMatrix(
                          DateFormat('EEEE').format(newDates(1)).toString())
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    maintainState: true,
                    title: Text(
                      "${newDates(2).day}/${newDates(2).month}/${newDates(2).year}" +
                          "   " +
                          "${DateFormat('EEEE').format(newDates(2))}",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 20)),
                    ),
                    children: <Widget>[
                      TimeSlotPickerMatrix(
                          DateFormat('EEEE').format(newDates(2)).toString())
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    maintainState: true,
                    title: Text(
                      "${newDates(3).day}/${newDates(3).month}/${newDates(3).year}" +
                          "   " +
                          "${DateFormat('EEEE').format(newDates(3))}",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 20)),
                    ),
                    children: <Widget>[
                      TimeSlotPickerMatrix(
                          DateFormat('EEEE').format(newDates(3)).toString())
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    maintainState: true,
                    title: Text(
                      "${newDates(4).day}/${newDates(4).month}/${newDates(4).year}" +
                          "   " +
                          "${DateFormat('EEEE').format(newDates(4))}",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 20)),
                    ),
                    children: <Widget>[
                      TimeSlotPickerMatrix(
                          DateFormat('EEEE').format(newDates(4)).toString())
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    maintainState: true,
                    title: Text(
                      "${newDates(5).day}/${newDates(5).month}/${newDates(5).year}" +
                          "   " +
                          "${DateFormat('EEEE').format(newDates(5))}",
                      // pickedDate.day < noofmonths()
                      //     ? "${pickedDate.day + (noofmonths() - pickedDate.day)}/${pickedDate.month}/${pickedDate.year}"
                      //     : "",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 20)),
                    ),
                    children: <Widget>[
                      TimeSlotPickerMatrix(
                          DateFormat('EEEE').format(newDates(5)).toString())
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    maintainState: true,
                    title: Text(
                      "${newDates(6).day}/${newDates(6).month}/${newDates(6).year}" +
                          "   " +
                          "${DateFormat('EEEE').format(newDates(6))}",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 20)),
                    ),
                    children: <Widget>[
                      TimeSlotPickerMatrix(
                          DateFormat('EEEE').format(newDates(6)).toString())
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: FlatButton(
                      child: Text(
                        "Submit Schedule",
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.deepOrangeAccent)),
                      onPressed: () {
                        submit();
                      },
                    ),
                  ),
                ],
              ),
            )),
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
