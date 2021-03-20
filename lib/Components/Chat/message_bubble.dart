import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.isMe, this.key, this.username, this.doc);
  final String message;
  final bool isMe;
  final String username;
  final Key key;
  final bool doc;

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
                  color: isMe ? Color(0xffD3D3D3) : Color(0xff614385),
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
                          color: isMe ? Color(0xff696969) : Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      message,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Metropolis',
                          color: isMe ? Color(0xff696969) : Colors.white,
                          fontSize: 15,
                          height: 1.2),
                    ),
                    doc
                        ? IconButton(
                            icon: Icon(Icons.download_rounded),
                          )
                        : SizedBox(height: 0, width: 0)
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
