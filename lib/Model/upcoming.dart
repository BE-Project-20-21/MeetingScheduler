import 'package:authentication_app/Model/upcoming_cards.dart';
import 'package:flutter/material.dart';

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
      itemCount: 4,
      itemBuilder: (BuildContext ctxt, int index) {
        return Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: UpcomingCards());
      },
    );
  }
}
