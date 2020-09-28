import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

var sundayMap = new Map<String, bool>();
var mondayMap = new Map<String, bool>();
var tuesdayMap = new Map<String, bool>();
var wednesdayMap = new Map<String, bool>();
var thursdayMap = new Map<String, bool>();
var fridayMap = new Map<String, bool>();
var saturdayMap = new Map<String, bool>();

class TimeSlots extends StatefulWidget {
  String time;
  String day;
  TimeSlots(String time, String day){
    this.time = time;
    this.day = day;
    sundayMap.clear();
    mondayMap.clear();
    tuesdayMap.clear();
    wednesdayMap.clear();
    thursdayMap.clear();
    fridayMap.clear();
    saturdayMap.clear();
  }

  @override
  _TimeSlotsState createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {
  //var Schedule = new List();
  var listSunday = new List();
  bool pressed = false;
  int counter = 1;

  @override
  void initState() {
    super.initState();
    pressed;
    counter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: FlatButton(
            child: Text(
              "${widget.time}",
              style: GoogleFonts.sourceSansPro(
                  textStyle: TextStyle(
                      color: pressed ? Colors.white : Colors.deepOrangeAccent)),
              overflow: TextOverflow.clip,
            ),
            onHighlightChanged: (value) => {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onPressed: () {
              setState(() {
                pressed = true;
                counter = counter + 1;
              });
              if (counter % 2 != 0) {
                setState(() {
                  pressed = false;
                  removeFromSchedule(widget.day, widget.time);
                });
              }
              else{
                addToSchedule(widget.day, widget.time);
              }
            },
            color: pressed ? Colors.deepOrange : Colors.white,
          ),
        ),
      ),
    );
  }

  void addToSchedule(String day, String time) {
    if (day == "Sunday"){
      sundayMap[widget.time] = true;
      Fluttertoast.showToast(msg: "Sunday: $sundayMap");
    }
  }

  void removeFromSchedule(String day, String time) {
    if (day == "Sunday"){
      sundayMap[widget.time] = false;
      Fluttertoast.showToast(msg: "Sunday: $sundayMap");
    }
  }
}