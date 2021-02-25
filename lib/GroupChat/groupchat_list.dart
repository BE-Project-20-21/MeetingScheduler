import 'package:flutter/material.dart';
import "../UI/dashboard.dart";
import '../GroupChat/chat_screen.dart';

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
    return GestureDetector(
      onTap: () {
        //Navigating to the Groupchat
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(widget._meetingId, temp1['subject'])));
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
                      temp1["subject"],
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