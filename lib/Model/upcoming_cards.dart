import 'package:authentication_app/UI/dashboard.dart';
import 'package:flutter/material.dart';

class UpcomingCards extends StatelessWidget {
  String _meetingID;
  UpcomingCards(String meetingID) {
    this._meetingID = meetingID;
  }

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> temp = new Map<dynamic, dynamic>();
    temp = upcomingMeetings[_meetingID];
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 380,
      height: 147,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [
              Color(0xFF7B38C6),
              Color(0xFF9543AA),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              temp["subject"],
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              temp["day"],
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              "Meeting Timings: ${temp["starTime"]} : 00 - ${temp["endTime"]} : 00",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
