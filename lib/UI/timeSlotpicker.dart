import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Model/time_slots.dart';

class TimeSlotPickerMatrix extends StatefulWidget {
  final String day;
  TimeSlotPickerMatrix(this.day);

  @override
  TimeSlotPickerMatrixState createState() => TimeSlotPickerMatrixState();
}

class TimeSlotPickerMatrixState extends State<TimeSlotPickerMatrix> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height / 3.5,
      margin: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepOrangeAccent, width: 1),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TimeSlots('00:00',widget.day),
              TimeSlots('01:00',widget.day),
              TimeSlots('02:00',widget.day),
              TimeSlots('03:00',widget.day),
              TimeSlots('04:00',widget.day),
              TimeSlots('05:00',widget.day),
            ],
          ),
          Row(
            children: <Widget>[
              TimeSlots('06:00',widget.day),
              TimeSlots('07:00',widget.day),
              TimeSlots('08:00',widget.day),
              TimeSlots('09:00',widget.day),
              TimeSlots('10:00',widget.day),
              TimeSlots('11:00',widget.day),
            ],
          ),
          Row(
            children: <Widget>[
              TimeSlots('12:00',widget.day),
              TimeSlots('13:00',widget.day),
              TimeSlots('14:00',widget.day),
              TimeSlots('15:00',widget.day),
              TimeSlots('16:00',widget.day),
              TimeSlots('17:00',widget.day),
            ],
          ),
          Row(
            children: <Widget>[
              TimeSlots('18:00',widget.day),
              TimeSlots('19:00',widget.day),
              TimeSlots('20:00',widget.day),
              TimeSlots('21:00',widget.day),
              TimeSlots('22:00',widget.day),
              TimeSlots('23:00',widget.day),
            ],
          ),
        ],
      ),
    );
  }
}
