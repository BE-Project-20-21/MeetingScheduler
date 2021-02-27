import 'package:flutter/material.dart';
import './time_slots.dart';

class TimeSlotPickerMatrix extends StatefulWidget {
  final String day;
  TimeSlotPickerMatrix(this.day);

  @override
  TimeSlotPickerMatrixState createState() => TimeSlotPickerMatrixState();
}

class TimeSlotPickerMatrixState extends State<TimeSlotPickerMatrix> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Flex(direction: Axis.vertical, children: [
      // Container(
      //   width: width,
      //   height: height / 3.5,
      //   margin: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(12),
      //     border: Border.all(color: Colors.deepOrangeAccent, width: 1),
      //   ),
      Flex(
        direction: Axis.horizontal,
        children: [
          TimeSlots(0, widget.day, false),
          TimeSlots(1, widget.day, false),
          TimeSlots(2, widget.day, false),
          TimeSlots(3, widget.day, false),
          TimeSlots(4, widget.day, false),
          TimeSlots(5, widget.day, false),
        ],
      ),
      Flex(
        direction: Axis.horizontal,
        children: [
          TimeSlots(6, widget.day, false),
          TimeSlots(7, widget.day, false),
          TimeSlots(8, widget.day, false),
          TimeSlots(9, widget.day, false),
          TimeSlots(10, widget.day, false),
          TimeSlots(11, widget.day, false),
        ],
      ),
      Flex(
        direction: Axis.horizontal,
        children: [
          TimeSlots(12, widget.day, false),
          TimeSlots(13, widget.day, false),
          TimeSlots(14, widget.day, false),
          TimeSlots(15, widget.day, false),
          TimeSlots(16, widget.day, false),
          TimeSlots(17, widget.day, false),
        ],
      ),
      Flex(
        direction: Axis.horizontal,
        children: [
          TimeSlots(18, widget.day, false),
          TimeSlots(19, widget.day, false),
          TimeSlots(20, widget.day, false),
          TimeSlots(21, widget.day, false),
          TimeSlots(22, widget.day, false),
          TimeSlots(23, widget.day, false),
        ],
      ),
    ]);
  }
}
