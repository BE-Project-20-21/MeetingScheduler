import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.isMe, this.key, this.username);
  final String message;
  final bool isMe;
  final String username;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.purple[900] : Colors.blue[700],
              borderRadius: BorderRadius.circular(12),
            ),
            width: 160,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  username,
                  style: TextStyle(
                      fontFamily: 'Metropolis',
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style:
                      TextStyle(fontFamily: 'Metropolis', color: Colors.white),
                ),
              ],
            ),
          ),
        ]);
  }
}
