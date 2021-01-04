import 'package:flutter/material.dart';

import '../Model/confirm_slots.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';


import '../UI/scheduling_interface.dart';
import 'package:firebase_database/firebase_database.dart';

class DaySelect extends StatefulWidget {
  DaySelect({Key key}) : super(key: key);

  @override
  _DaySelectState createState() => _DaySelectState();
}

class _DaySelectState extends State<DaySelect> {
  @override
  Widget build(BuildContext context) {
    String daySelected = "";
    return Container(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: DropdownSearch<String>(
            mode: Mode.BOTTOM_SHEET,
            maxHeight: 300,
            items: [
              "Sunday",
              "Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday"
            ],
            dropDownButton: DropdownButton(
              icon: Icon(Icons.arrow_circle_down),
              iconDisabledColor: Color(0xFF398AE5),
              iconSize: 30,
            ),
            dropdownSearchDecoration: InputDecoration(
              hintText: "Select a Day!",
              hintStyle: TextStyle(
                  color: Color(0xFF398AE5),
                  letterSpacing: 1,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF398AE5)),
                  borderRadius: BorderRadius.circular(20)),
              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
            ),
            popupBarrierColor: Colors.white,
            onChanged: (day) {
              daySelected = day;
              //Method to fetch common empty slots for the day as soon as the user selects a day
              fetchEmptySlots(daySelected);
            },
            popupBackgroundColor: Colors.white,
            showClearButton: true,
            showSearchBox: true,
            searchBoxDecoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
              labelText: "Search the day!",
            ),
            popupTitle: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF398AE5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  'Conduct a meet on?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            popupShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          child: ConfirmSlots(),
          // decoration: BoxDecoration(
          //     color: Colors.white, borderRadius: BorderRadius.circular(20)),
          // child: ExpansionTile(
          //   maintainState: true,
          //   title: Text(
          //     "Choose Slots",
          //     style: GoogleFonts.aBeeZee(
          //         textStyle:
          //             TextStyle(color: Color(0xFF398AE5), fontSize: 15),
          //         letterSpacing: 1,
          //         fontWeight: FontWeight.bold),
          //   ),
          //   children: [ConfirmSlots()],
          // )
        )
      ]),
    );
  }

  void fetchEmptySlots(String daySelected) async {
    print("selected Uid: $selectedNames");
    print("Day selected: $daySelected");
    int test = selectedNames.elementAt(0).trim().length;
    print("test: $test");
    //Declaring the firebase instances and references
    FirebaseDatabase databaseSlots = new FirebaseDatabase();
    DatabaseReference referenceSlots =
        databaseSlots.reference().child("schedule");
    List<dynamic> referenceSchedule = [];
    var recurringSet = <int>{};
    var tempSet = <int>{};
    if (totalSelected != 0) {
      for (int i = 0; i < selectedNames.length; i++) {
        if (i == 0) {
          await referenceSlots
              .child(selectedNames.elementAt(i).trim())
              .child(daySelected)
              .once()
              .then((DataSnapshot dataSnapshot1) {
            referenceSchedule = dataSnapshot1.value;
            print("Schedule: $referenceSchedule");
            for (int j = 0; j < referenceSchedule.length; j++) {
              if (referenceSchedule.elementAt(j) == "true") {
                recurringSet.add(j);
              }
            }
            print("individual Set: $recurringSet");
          });
        } else {
          await referenceSlots
              .child(selectedNames.elementAt(i).trim())
              .child(daySelected)
              .once()
              .then((DataSnapshot dataSnapshot1) {
            referenceSchedule = dataSnapshot1.value;
            print("Schedule: $referenceSchedule");
          });
          for (int j = 0; j < referenceSchedule.length; j++) {
            if (referenceSchedule.elementAt(j) == "true") {
              tempSet.add(j);
            }
          }
          recurringSet = tempSet.intersection(recurringSet);
          tempSet.clear();
          print("individual Set: $recurringSet");
        }
      }
      print("Commom FreeSlots: $recurringSet");
    } else {
      Fluttertoast.showToast(
          msg: "Please select atleast one member for the meeting");
    }

    commonslots = recurringSet.toList();
  }
}
