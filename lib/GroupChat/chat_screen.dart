import '../GroupChat/new_message.dart';
import '../GroupChat/messages.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  String _meetingID;

  ChatScreen(String meetingID) {
    this._meetingID = meetingID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(child: Messages(_meetingID)),
            NewMessage(_meetingID)
          ],
        ),
      ),
    );
  }
}
