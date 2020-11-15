import 'package:authentication_app/Model/time_slots.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';
import './timeSlotpicker.dart';

class ManageSchedule extends StatefulWidget {
  @override
  _ManageScheduleState createState() => _ManageScheduleState();
}

class _ManageScheduleState extends State<ManageSchedule> {
  //Creating an object of ProgressDialog
  ProgressDialog progressDialogSchedule;

  DateTime startTime;
  DateTime endTime;
  var pickedDate = new DateTime.now();
  var dateUtility = new DateUtil();
  @override
  void initState() {
    super.initState();
    startTime = null;
    endTime = null;
    triggerRetrieve();
  }

  triggerRetrieve() async {
    //Here Goes the entire code to check if schedule already submitted
    // and if submitted read the schedule from the Database and reflect the schedule on the application
    //Starting the progress bar for the period to gather the already submitted schedule

    //Getting the authentication reference and getting the current user data
    FirebaseAuth authSchedule = FirebaseAuth.instance;
    User userSchedule = authSchedule.currentUser;
    String uidSchedule = userSchedule.uid.toString();

    //Code to show the progress bar
    progressDialogSchedule = new ProgressDialog(context,
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

    //Code to check whether the schedule exists
    FirebaseDatabase databaseSchedule = new FirebaseDatabase();
    DatabaseReference referenceSchedule =
        databaseSchedule.reference().child("schedule");
    referenceSchedule
        .reference()
        .child(uidSchedule)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        //Code to load the existing schedule and populate the Maps
        displaySchedule(uidSchedule);
      } else {
        progressDialogSchedule.hide();
      }
    });
  }

  //Method to display the pre-submitted schedule
  void displaySchedule(String uidSchedule) async {
    //Saving each node containing the day name in the list
    var listDays = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ];

    //Retrieving schedule from the database and populating the maps
    FirebaseDatabase databaseRetrieveSchdeule = new FirebaseDatabase();
    DatabaseReference referenceRetrieveSchdeule = databaseRetrieveSchdeule
        .reference()
        .child("schedule")
        .child(uidSchedule);
    //Code to retrieve the data from the database
    //Iterating over the list to save the schedule for ith index day in the list from the database to the map for that day
    for (int i = 0; i < listDays.length; i++) {
      await referenceRetrieveSchdeule
          .child(listDays.elementAt(i))
          .once()
          .then((DataSnapshot datasnapshot) {
        List<dynamic> slots = datasnapshot.value;
        print("$slots");
        //Code to save the entire schedule for a day into the map and then shift it to the schedule map
        for (int j = 0; j < slots.length; j++) {
          if (listDays.elementAt(i) == "Sunday") {
            sundayMap[j] = slots.elementAt(j);
          } else if (listDays.elementAt(i) == "Monday") {
            mondayMap[j] = slots.elementAt(j);
          } else if (listDays.elementAt(i) == "Tuesday") {
            tuesdayMap[j] = slots.elementAt(j);
          } else if (listDays.elementAt(i) == "Wednesday") {
            wednesdayMap[j] = slots.elementAt(j);
          } else if (listDays.elementAt(i) == "Thursday") {
            thursdayMap[j] = slots.elementAt(j);
          } else if (listDays.elementAt(i) == "Friday") {
            fridayMap[j] = slots.elementAt(j);
          } else if (listDays.elementAt(i) == "Saturday") {
            saturdayMap[j] = slots.elementAt(j);
          }
        }
      });
    }
    progressDialogSchedule.hide();
  }

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
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
