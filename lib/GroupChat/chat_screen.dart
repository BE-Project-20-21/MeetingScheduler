import '../GroupChat/new_message.dart';
import '../GroupChat/messages.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  String _meetingID;
  String subject;
  ChatScreen(String meetingID, String subject) {
    this._meetingID = meetingID;
    this.subject = subject;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xff2A2136),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: Color(0xff2A2136),
            elevation: 5,
            title: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    subject,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )),
      body: Container(
        color: Colors.white,
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
