import 'package:flutter/material.dart';
import "../Dashboard/dashboard.dart";
import '../Chat/chat_screen.dart';

//Variables required to save data about the meeting
Map<dynamic, dynamic> temp1 = new Map<dynamic, dynamic>();

class GroupChatList extends StatefulWidget {
  String _meetingId;
  GroupChatList(String meetingId) {
    this._meetingId = meetingId;
  }
  GroupChatListState createState() => GroupChatListState();
}

class GroupChatListState extends State<GroupChatList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        //Navigating to the Groupchat
        String meetSubject = (upcomingMeetings[widget._meetingId])["subject"];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(widget._meetingId, meetSubject)));
      },
      child: Opacity(
        opacity: 1.0,
        child: Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Container(
            height: 80.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff3d2f4f).withOpacity(.8),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Opacity(
                opacity: 1.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      (upcomingMeetings[widget._meetingId])["subject"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
