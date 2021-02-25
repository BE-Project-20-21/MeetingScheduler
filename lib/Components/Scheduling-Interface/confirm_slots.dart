import 'package:flutter/material.dart';
import './scheduling_interface.dart';
import './generate_confirm_slots.dart';

class ConfirmSlots extends StatefulWidget {
  @override
  _ConfirmSlotsState createState() => _ConfirmSlotsState();
}

class _ConfirmSlotsState extends State<ConfirmSlots> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
      child: GridView.builder(
          itemCount: commonslots.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
          itemBuilder: (BuildContext ctxt, int index) {
            return Container(margin: EdgeInsets.all(2), child: GCS(index));
          }),
    ));
  }
}
