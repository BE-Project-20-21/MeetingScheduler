import 'package:authentication_app/Model/engine_response_bubble.dart';
import 'package:authentication_app/UI/days_slots_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../Model/search.dart';
import '../UI/days_slots_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

//variable to store the selected members
var selectedMembers = Map();
var selectedNames = <String>{};
var membersNames = List();
int totalSelected = selectedNames.length;

class ScheduleInterface extends StatefulWidget {
  bool membersSelectedWidget;
  ScheduleInterface(bool membersSelectedWidget) {
    this.membersSelectedWidget = membersSelectedWidget;
  }

  @override
  _ScheduleInterfaceState createState() => _ScheduleInterfaceState();
}

class _ScheduleInterfaceState extends State<ScheduleInterface> {
  //Variables(boolean) to handle the UI bot messages rendering
  bool membersSelected = false;
  bool membersConfirmed = false;
  bool subjectGiven = false;
  bool dayChoosen = false;
  bool dayConfirmed = false;
  bool selectAday = false;

  //Variables to lock irreversible commits on the scheduling interface
  bool membersLocked = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      membersSelected = widget.membersSelectedWidget;
    });
  }

  List<String> responseList = [
    "Welcome to the Meeting Scheduling Interface, please select the members of the meeting by pressing the button below",
    "Please confirm or edit",
    "Please input a subject for the meeting in the box below",
    "Please select a day for the meeting in the upcoming week!",
    "Generating possible slots",
    "Here are the common slots, please select as many as you want to book",
    "Meeting is now pending for approval from fellow members, please keep an eye on the pending tab for conformation",
    "Have a good day!"
  ];

  String subject = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Scheduling Interface",
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.aBeeZeeTextTheme(
              Theme.of(context).textTheme,
            )),
        home: Material(
          child: Scaffold(
            appBar: AppBar(
              title: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "New Meeting",
                        style: GoogleFonts.hammersmithOne(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                letterSpacing: 1)),
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
            ),
            body: Container(
              margin: EdgeInsets.only(top: 10),
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ERBubble("${responseList[0]}"),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Container(
                            margin: EdgeInsets.only(right: 30),
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () {
                                if (membersSelected) {
                                  if (membersLocked) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "The members os the meeting are confirmed! Cannot make changes");
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please edit the list of members selected");
                                  }
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Search()));
                                }
                              },
                              padding: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Colors.white,
                              child: Text(
                                "Search Members",
                                style: TextStyle(
                                  color: Color(0xFF398AE5),
                                  letterSpacing: 1,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Opacity(
                            opacity: membersSelected ? 1.0 : 0.0,
                            child: ERBubble("${responseList[1]}")),
                        Opacity(
                            opacity: membersSelected ? 1.0 : 0.0,
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: RaisedButton(
                                      elevation: 5.0,
                                      onPressed: () {
                                        //Here goes the code to navigate back to search page to edit the members
                                        if (!membersLocked) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Search()));
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "You cannot makes changes now!");
                                        }
                                      },
                                      padding: EdgeInsets.all(10.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.white,
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: Color(0xFF398AE5),
                                          letterSpacing: 1,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 30),
                                    child: RaisedButton(
                                      elevation: 5.0,
                                      onPressed: () {
                                        //Here goes the code to confirm the mebers selected
                                        if (!membersLocked) {
                                          setState(() {
                                            membersConfirmed = true;
                                          });
                                          membersLocked = true;
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Members already confirmed!");
                                        }
                                      },
                                      padding: EdgeInsets.all(10.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.white,
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          color: Color(0xFF398AE5),
                                          letterSpacing: 1,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Opacity(
                          opacity: membersConfirmed ? 1.0 : 0.0,
                          child: ERBubble(
                              "The Selected Members for the meeting are: " +
                                  membersNames.join(", ")),
                        ),
                        Opacity(
                            opacity: membersConfirmed ? 1.0 : 0.0,
                            child: ERBubble("${responseList[2]}")),
                        SizedBox(
                          height: 15,
                        ),
                        Opacity(
                          opacity: membersConfirmed ? 1.0 : 0.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 30),
                                      width: width / 2,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: TextField(
                                          onChanged: (subjectInput) {
                                            subject = subjectInput;
                                          },
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(top: 5.0),
                                              labelText: "Enter a Subject",
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1,
                                                  color: Color(0xFF398AE5))),
                                          autofocus: false,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6.0,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Container(
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          onPressed: () {
                                            if (subject != "") {
                                              setState(() {
                                                subjectGiven = true;
                                              });
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please provide the Subject for the meeting!");
                                            }
                                          },
                                          padding: EdgeInsets.all(10.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          color: Colors.white,
                                          child: Text(
                                            'Confirm Subject',
                                            style: TextStyle(
                                              color: Color(0xFF398AE5),
                                              letterSpacing: 1,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Opacity(
                            opacity: subjectGiven ? 1.0 : 0.0,
                            child: ERBubble("${responseList[3]}")),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Container(
                            margin: EdgeInsets.only(right: 30),
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DaySlotsPage()));
                              },
                              padding: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Colors.white,
                              child: Text(
                                "Select a Day",
                                style: TextStyle(
                                  color: Color(0xFF398AE5),
                                  letterSpacing: 1,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              )),
            ),
          ),
        ));
  }
}
