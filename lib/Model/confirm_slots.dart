import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UI/scheduling_interface.dart';
import '../Model/generate_confirm_slots.dart';

class ConfirmSlots extends StatefulWidget {
  @override
  _ConfirmSlotsState createState() => _ConfirmSlotsState();
}

class _ConfirmSlotsState extends State<ConfirmSlots> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
      child: ListView.builder(
          itemCount: commonslots.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return GCS(index);
          }),
    ));
  }
}
