import 'package:flutter/material.dart';
import '../GroupChat/groupchat_list.dart';
import "../UI/dashboard.dart";
import '../GroupChat/chat_screen.dart';

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
          padding: EdgeInsets.only(right: 10, left: 10),
          child: GroupChatList(upcomingList[index]),
        );
      },
    );
  }
}
