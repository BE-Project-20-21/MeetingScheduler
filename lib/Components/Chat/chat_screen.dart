import 'package:flutter/material.dart';
import '../Chat/new_message.dart';
import '../Chat/messages.dart';

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
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: PopupOptionMenuChat(),
              ),
            ],
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

//Menu facilitator
enum MenuOption { documents }

// Class to build the menu
class PopupOptionMenuChat extends StatelessWidget {
  const PopupOptionMenuChat({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupMenuButton<MenuOption>(
      color: Color(0xff2A2136),
      icon: Icon(Icons.menu, color: Colors.white),
      itemBuilder: (BuildContext context1) {
        return <PopupMenuEntry<MenuOption>>[
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.file_present,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    "Documents",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.all(0),
                )
              ],
            ),
            value: MenuOption.documents,
          ),
        ];
      },
      onSelected: (selection) {},
    );
  }
}
