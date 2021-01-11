import 'package:flutter/material.dart';
import '../UI/scheduling_interface.dart';
import 'package:google_fonts/google_fonts.dart';

class GCS extends StatefulWidget {
  final int index;
  GCS(this.index);

  @override
  _GCSState createState() => _GCSState();
}

class _GCSState extends State<GCS> {
  bool pressed = false;
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: FlatButton(
        child: FittedBox(
          child: Text(
            "${commonslots[widget.index]}" + ":00",
            overflow: TextOverflow.clip,
            style: GoogleFonts.sourceSansPro(
                textStyle: TextStyle(
                    color: pressed ? Colors.white : Color(0xFF398AE5))),
          ),
        ),
        onHighlightChanged: (value) => {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        color: pressed ? Colors.blueAccent : Colors.white,
      ),
    ));
  }
}
