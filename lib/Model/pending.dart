import 'package:authentication_app/Model/pending_cards.dart';
import 'package:flutter/material.dart';

class DashboardSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext ctxt, int index) {
        return Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: PendingCards());
      },
    );
  }
}