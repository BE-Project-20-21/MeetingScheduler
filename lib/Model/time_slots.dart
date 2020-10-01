import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

//The map for each day containing the time slots, and boolean value for each slot; true: free, false: occupied.
var sundayMap = new Map<int, bool>();
var mondayMap = new Map<int, bool>();
var tuesdayMap = new Map<int, bool>();
var wednesdayMap = new Map<int, bool>();
var thursdayMap = new Map<int, bool>();
var fridayMap = new Map<int, bool>();
var saturdayMap = new Map<int, bool>();

//Map to put the schedule of each day in one packet, ready to be pushed into the database
var schedule = new Map<String, Map>();

class TimeSlots extends StatefulWidget {
  int time;
  String day;
  bool trigger;
  var schedule = new Map();

  TimeSlots(int time, String day, bool trigger){
    this.time = time;
    this.day = day;
    this.trigger = trigger;
    //Triggered on clicking the Submit button on the manage_schedule page
    if (trigger){
      createMap();
    }
    //To clear the map every-time the user leaves the manage_schedule page and gets back to dashboard
    else{
      sundayMap.clear();
      mondayMap.clear();
      tuesdayMap.clear();
      wednesdayMap.clear();
      thursdayMap.clear();
      fridayMap.clear();
      saturdayMap.clear();
    }
  }

  @override
  _TimeSlotsState createState() => _TimeSlotsState();

  //Here comes the code when the user submits the schedule (Entering the schedule in the database)
  void createMap() {
    schedule["Sunday"] = sundayMap;
    schedule["Monday"] = mondayMap;
    schedule["Tuesday"] = tuesdayMap;
    schedule["Wednesday"] = wednesdayMap;
    schedule["Thursday"] = thursdayMap;
    schedule["Friday"] = fridayMap;
    schedule["Saturday"] = saturdayMap;
    Fluttertoast.showToast(msg: "Schedule: $schedule");
    vaidateMap(schedule);
  }

  void vaidateMap(Map schedule) {
    //Code to validate the schedule
    //Call method to add the validated schedule to the database
    submitSchedule(schedule);
  }

  void submitSchedule(Map schedule) {
    //Code to enter the shedule to the database
  }
}

class _TimeSlotsState extends State<TimeSlots> {
  //Variables required to handle the selected/un-selected state of each slot
  bool pressed = false;
  int counter = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: FlatButton(
            child: Text(
              "${widget.time.toString()}"+":00",
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

  //Method to make a particular slot value true for a particular day (select slot)
  void addToSchedule(String day, int time) {
    if (day == "Sunday"){
      sundayMap[widget.time] = true;
    }
    else if (day == "Monday"){
      mondayMap[widget.time] = true;
    }
    else if (day == "Tuesday"){
      tuesdayMap[widget.time] = true;
    }
    else if (day == "Wednesday"){
      wednesdayMap[widget.time] = true;
    }
    else if (day == "Thursday"){
      thursdayMap[widget.time] = true;
    }
    else if (day == "Friday"){
      fridayMap[widget.time] = true;
    }
    else if (day == "Saturday"){
      saturdayMap[widget.time] = true;
    }
  }

  //Method to make a particular slot value false for a particular day (un-select slot)
  void removeFromSchedule(String day, int time) {
    if (day == "Sunday"){
      sundayMap[widget.time] = false;
    }
    else if (day == "Monday"){
      mondayMap[widget.time] = false;
    }
    else if (day == "Tuesday"){
      tuesdayMap[widget.time] = false;
    }
    else if (day == "Wednesday"){
      wednesdayMap[widget.time] = false;
    }
    else if (day == "Thursday"){
      thursdayMap[widget.time] = false;
    }
    else if (day == "Friday"){
      fridayMap[widget.time] = false;
    }
    else if (day == "Saturday"){
      saturdayMap[widget.time] = false;
    }
  }
}