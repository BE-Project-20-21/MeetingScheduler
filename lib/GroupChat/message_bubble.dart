import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message,
    this.isMe,
    this.key,
    this.username,
  );
  final String message;
  final bool isMe;
  final String username;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isMe ? Color(0xff614385) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: isMe
                    ? EdgeInsets.only(left: 100, top: 10, right: 20)
                    : EdgeInsets.only(right: 100, top: 10, left: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      username,
                      style: TextStyle(
                          fontFamily: 'Metropolis',
                          fontSize: 15,
                          color: isMe ? Colors.white : Color(0xff3D2F4F),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      message,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Metropolis',
                          color: isMe ? Colors.white : Color(0xff3D2F4F),
                          fontSize: 15,
                          height: 1.2),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
