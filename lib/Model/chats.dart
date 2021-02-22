import '../UI/chat_screen.dart';
import 'package:flutter/material.dart';
import '../Model/chat_list.dart';

class Chats extends StatelessWidget {
  const Chats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Scaffold(
        backgroundColor: Color(0xff3d2f4f),
        body: Container(
            margin: EdgeInsets.all(20),
            height: 300,
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ChatList(),
                      RaisedButton(onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()));
                      })
                    ],
                  );
                })),
      ),
    );
  }
}
