import 'package:flutter/material.dart';
import "../UI/dashboard.dart";

class GroupChatList extends StatefulWidget {
  String _meetingId;
  GroupChatList(String meetingId) {
    this._meetingId = meetingId;
  }
  GroupChatListState createState() => GroupChatListState();
}

class GroupChatListState extends State<GroupChatList> {
  //Variables required to save data about the meeting
  Map<dynamic, dynamic> temp1 = new Map<dynamic, dynamic>();
  @override
  void initState() {
    temp1 = upcomingMeetings[widget._meetingId];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Opacity(
      opacity: 1.0,
      child: Container(
        margin: EdgeInsets.only(top: 5.0),
        child: Container(
          height: 50.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Opacity(
              opacity: 1.0,
              child: Text(
                temp1["subject"],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              )),
        ),
      ),
    );
  }
}
