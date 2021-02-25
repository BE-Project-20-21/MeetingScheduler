import 'package:flutter/material.dart';
import '../Chat/groupchat_list.dart';
import "../Dashboard/dashboard.dart";

class GroupChat extends StatefulWidget {
  @override
  GroupChatState createState() => GroupChatState();
}

class GroupChatState extends State<GroupChat> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: upcomingList.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Padding(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: GroupChatList(upcomingList[index]),
        );
      },
    );
  }
}
