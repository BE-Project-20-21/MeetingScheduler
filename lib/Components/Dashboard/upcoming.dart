import 'package:flutter/material.dart';
import './dashboard.dart';
import './upcoming_cards.dart';

class DashboardFirst extends StatefulWidget {
  @override
  _DashboardFirstState createState() => _DashboardFirstState();
}

class _DashboardFirstState extends State<DashboardFirst> {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return ListView.builder(
      itemCount: upcomingList.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: UpcomingCards(upcomingList[index]));
      },
    );
  }
}
