import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UI/scheduling_interface.dart';

class ConfirmSlots extends StatefulWidget {
  @override
  _ConfirmSlotsState createState() => _ConfirmSlotsState();
}

class _ConfirmSlotsState extends State<ConfirmSlots> {
  bool pressed = false;
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
      child: ListView.builder(
          itemCount: commonslots.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "${commonslots[index]}" + ":00",
                        style: GoogleFonts.sourceSansPro(
                            textStyle: TextStyle(
                                color: pressed
                                    ? Colors.white
                                    : Color(0xFF398AE5))),
                        overflow: TextOverflow.clip,
                      ),
                      onHighlightChanged: (value) => {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        //Logic to implement the selection and discarding of a particular time slot
                        setState(() {
                          pressed = true;
                          counter = counter + 1;
                        });
                        if (counter % 2 != 0) {
                          setState(() {
                            pressed = false;
                          });
                        }
                      },
                      color: pressed ? Color(0xFF61A4F1) : Colors.white,
                    ),
                  ]),
            );
          }),
    ));
  }
}
