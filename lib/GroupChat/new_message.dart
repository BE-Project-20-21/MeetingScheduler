import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  String _meetingID;

  NewMessage(String meetingID) {
    this._meetingID = meetingID;
  }

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('names')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection(widget._meetingID).add({
      'text': _enteredMessage,
      'sentAt': Timestamp.now(),
      'userid': user.uid,
      'username': userData['name'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              cursorColor: Color(0xff3D2F4F),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff3D2F4F)),
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'Send a message...',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff3D2F4F)),
                      borderRadius: BorderRadius.circular(12)),
                  hintStyle: TextStyle(color: Color(0xff3D2F4F))),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          Container(
            width: 40,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              disabledColor: Color(0xff3D2F4F),
              icon: Icon(Icons.scanner_rounded),
              color: Color(0xff3D2F4F),
              onPressed: () {},
            ),
          ),
          Container(
            width: 40,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              disabledColor: Color(0xff3D2F4F),
              icon: Icon(Icons.attach_file_rounded),
              color: Color(0xff3D2F4F),
              onPressed: () {},
            ),
          ),
          Container(
            width: 40,
            margin: EdgeInsets.only(left: 10),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: IconButton(
              disabledColor: Color(0xff3D2F4F),
              icon: Icon(Icons.send_rounded),
              color: Color(0xff3D2F4F),
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            ),
          )
        ],
      ),
    );
  }
}
