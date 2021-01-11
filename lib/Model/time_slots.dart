import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../UI/dashboard.dart';
import '../UI/manage_schedule.dart';

//Map to put the schedule of each day in one packet, ready to be pushed into the database
var schedule = new Map<String, Map>();

//Global context for the Timeslots widget
BuildContext globalContextTimeSlots;

class TimeSlots extends StatefulWidget {
  int time;
  String day;
  bool trigger;
  var schedule = new Map();

  TimeSlots(int time, String day, bool trigger) {
    this.time = time;
    this.day = day;
    this.trigger = trigger;
    //Triggered on clicking the Submit button on the manage_schedule page
    if (trigger) {
      createMap();
    }
  }

  @override
  _TimeSlotsState createState() => _TimeSlotsState();

  //Creating an object of ProgressDialog
  ProgressDialog progressDialog;

  //Here comes the code when the user submits the schedule (Entering the schedule in the database)
  void createMap() {
    schedule["Sunday"] = sundayMap;
    schedule["Monday"] = mondayMap;
    schedule["Tuesday"] = tuesdayMap;
    schedule["Wednesday"] = wednesdayMap;
    schedule["Thursday"] = thursdayMap;
    schedule["Friday"] = fridayMap;
    schedule["Saturday"] = saturdayMap;

    //Code to show the progres bar (UI BASED)
    progressDialog = new ProgressDialog(globalContextTimeSlots,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialog.style(
      child: Container(
        color: Colors.white,
        child: CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
        ),
        margin: EdgeInsets.all(10.0),
      ),
      message: "Submitting your Schedule....",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 40.0,
      progress: 0.0,
      maxProgress: 100.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0),
      messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0),
    );
    progressDialog.show();

    //Calling the function to validate the schedule
    vaidateMap(schedule);
  }

  void vaidateMap(Map schedule) {
    //Calling the method to call dialog box
    //Code to validate the schedule
    //Call method to add the validated schedule to the database
    submitSchedule(schedule);
  }

  //Method to Enter the schedule to the database
  void submitSchedule(Map schedule) {
    //To get the UID of the current User
    final String currentUserId = FirebaseAuth.instance.currentUser.uid;
    //Declaring Database references and setting th ereference to the target node
    FirebaseDatabase databaseManageSchedule = new FirebaseDatabase();
    DatabaseReference referenceManageSchedule =
        databaseManageSchedule.reference().child("schedule");

    //Code to enter the shedule to the database
    bool slotStatus = false;
    for (String days in schedule.keys) {
      for (int i = 0; i < 24; i++) {
        if (schedule[days].containsKey(i)) {
          slotStatus = schedule[days][i];
        } else {
          slotStatus = false;
        }
        //Inserting the slot-status in the database
        referenceManageSchedule.child(currentUserId).child(days).update({
          i.toString(): slotStatus.toString(),
        });
      }
    }

    //To hide the progress bar and Navigate to the dashboard
    closeActivity();
  }

  closeActivity() {
    //Code to hide the progress bar
    Future.delayed(const Duration(seconds: 2), () {
      progressDialog.hide();
    });
    //Code to implement the navigation right after submitting the schedule
  }
}

class _TimeSlotsState extends State<TimeSlots> {
  //Creating an object of ProgressDialog
  ProgressDialog progressDialogSchedule;

  //Variables required to handle the selected/un-selected state of each slot
  bool pressed = false;
  int counter = 1;

  // @override
  // void initState() async {
  //   super.initState();
  //   //Here Goes the entire code to check if schedule already submitted
  //   // and if submitted read the schedule from the Database and reflect the schedule on the application
  //   //Starting the progress bar for the period to gather the already submitted schedule

  //   //Getting the authentication reference and getting the current user data
  //   FirebaseAuth authSchedule = FirebaseAuth.instance;
  //   User userSchedule = authSchedule.currentUser;
  //   String uidSchedule = userSchedule.uid.toString();

  //   //Code to check whether the schedule exists
  //   FirebaseDatabase databaseSchedule = new FirebaseDatabase();
  //   DatabaseReference referenceSchedule =
  //       databaseSchedule.reference().child("schedule");
  //   await referenceSchedule
  //       .reference()
  //       .child("schedule")
  //       .child(uidSchedule)
  //       .once()
  //       .then((DataSnapshot dataSnapshot) {
  //     if (dataSnapshot.value != null) {
  //       //Code to load the existing schedule and populate the Maps
  //       displaySchedule(uidSchedule);
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    //Setting the UI rendering parameters to not normal (pressed)
    if (widget.day == "Sunday") {
      if (sundayMap[widget.time] == true) {
        setState(() {
          pressed = true;
          counter = counter + 1;
        });
      }
    } else if (widget.day == "Monday") {
      if (mondayMap[widget.time] == true) {
        setState(() {
          pressed = true;
          counter = counter + 1;
        });
      }
    } else if (widget.day == "Tuesday") {
      if (tuesdayMap[widget.time] == true) {
        setState(() {
          pressed = true;
          counter = counter + 1;
        });
      }
    } else if (widget.day == "Wednesday") {
      if (wednesdayMap[widget.time] == true) {
        setState(() {
          pressed = true;
          counter = counter + 1;
        });
      }
    } else if (widget.day == "Thursday") {
      if (thursdayMap[widget.time] == true) {
        setState(() {
          pressed = true;
          counter = counter + 1;
        });
      }
    } else if (widget.day == "Friday") {
      if (fridayMap[widget.time] == true) {
        setState(() {
          pressed = true;
          counter = counter + 1;
        });
      }
    } else if (widget.day == "Saturday") {
      if (saturdayMap[widget.time] == true) {
        setState(() {
          pressed = true;
          counter = counter + 1;
        });
      }
    }
  }

  //Method to display the pre-submitted schedule
  void displaySchedule(String uidSchedule) {
    //Code to show the progress bar
    progressDialogSchedule = new ProgressDialog(globalContextTimeSlots,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialogSchedule.style(
      child: Container(
        color: Colors.white,
        child: CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
        ),
        margin: EdgeInsets.all(10.0),
      ),
      message: "Submitting your Schedule....",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 40.0,
      progress: 0.0,
      maxProgress: 100.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0),
      messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0),
    );
    progressDialogSchedule.show();

    //Retrieving schedule from the database and populating the maps
  }

  @override
  Widget build(BuildContext context) {
    globalContextTimeSlots = context;
    return Container(
      child: Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: FlatButton(
            child: FittedBox(
              child: Text(
                "${widget.time.toString()}" + ":00",
                style: GoogleFonts.sourceSansPro(
                    textStyle: TextStyle(
                        color: pressed ? Colors.white : Color(0xFF398AE5))),
                overflow: TextOverflow.clip,
              ),
            ),
            onHighlightChanged: (value) => {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onPressed: () {
              //Logic to implement the selection and discarding of a particular time slot
              setState(() {
                pressed = true;
                counter = counter + 1;
              });
              if (counter % 2 != 0) {
                setState(() {
                  pressed = false;
                  removeFromSchedule(widget.day, widget.time);
                });
              } else {
                addToSchedule(widget.day, widget.time);
              }
            },
            color: pressed ? Colors.blueAccent : Colors.white,
          ),
        ),
      ),
    );
  }

  //Method to make a particular slot value true for a particular day (select slot)
  void addToSchedule(String day, int time) {
    if (day == "Sunday") {
      sundayMap[widget.time] = true;
    } else if (day == "Monday") {
      mondayMap[widget.time] = true;
    } else if (day == "Tuesday") {
      tuesdayMap[widget.time] = true;
    } else if (day == "Wednesday") {
      wednesdayMap[widget.time] = true;
    } else if (day == "Thursday") {
      thursdayMap[widget.time] = true;
    } else if (day == "Friday") {
      fridayMap[widget.time] = true;
    } else if (day == "Saturday") {
      saturdayMap[widget.time] = true;
    }
  }

  //Method to make a particular slot value false for a particular day (un-select slot)
  void removeFromSchedule(String day, int time) {
    if (day == "Sunday") {
      sundayMap[widget.time] = false;
    } else if (day == "Monday") {
      mondayMap[widget.time] = false;
    } else if (day == "Tuesday") {
      tuesdayMap[widget.time] = false;
    } else if (day == "Wednesday") {
      wednesdayMap[widget.time] = false;
    } else if (day == "Thursday") {
      thursdayMap[widget.time] = false;
    } else if (day == "Friday") {
      fridayMap[widget.time] = false;
    } else if (day == "Saturday") {
      saturdayMap[widget.time] = false;
    }
  }
}
