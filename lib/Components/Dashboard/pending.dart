import 'package:flutter/material.dart';
import './pending_cards.dart';
import './dashboard.dart';

class DashboardSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: pendingList.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: PendingCards(pendingList[index]));
      },
    );
  }
}
