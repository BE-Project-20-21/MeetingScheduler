import 'package:authentication_app/Model/engine_response.dart';
import 'package:authentication_app/Model/engine_response_bubble.dart';
import 'package:authentication_app/Model/si_buttons.dart';
import 'package:authentication_app/Model/search.dart';
import 'package:authentication_app/Model/si_inputButtons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ScheduleInterface extends StatefulWidget {
  ScheduleInterface({Key key}) : super(key: key);

  @override
  _ScheduleInterfaceState createState() => _ScheduleInterfaceState();
}

class _ScheduleInterfaceState extends State<ScheduleInterface> {
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
          child: Container(
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
                      SIInput("Search", "Search Members"),
                      ERBubble("${responseList[1]}"),
                      SIButtons(),
                      ERBubble("${responseList[2]}"),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 30),
                              width: width / 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextField(
                                  onChanged: (subjectInput) {
                                    subject = subjectInput;
                                  },
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5.0),
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
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ERBubble("${responseList[3]}"),
                    ]),
              ),
            )),
          ),
        ));
  }
}
