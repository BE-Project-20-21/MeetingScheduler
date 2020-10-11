import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashboardFirst extends StatefulWidget {
  @override
  _DashboardFirstState createState() => _DashboardFirstState();
}

class _DashboardFirstState extends State<DashboardFirst> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepOrangeAccent,
              Colors.redAccent,
              Colors.red,
            ]),
      ),
    );
  }
}
