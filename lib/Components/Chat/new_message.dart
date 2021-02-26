import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../OCR/ocr.dart';
import '../File-Attachment/attachments_screen.dart';

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
    //Handling the events that occur on clicking the send button
    if (_enteredMessage != "" && _enteredMessage != null) {
      FocusScope.of(context).unfocus();
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('names')
          .doc(user.uid)
          .get();
      FirebaseFirestore.instance.collection(widget._meetingID).add({
        'text': _enteredMessage.trim(),
        'sentAt': Timestamp.now(),
        'userid': user.uid,
        'username': userData['name'],
      });
      _controller.clear();
      _enteredMessage = null;
    } else {
      Fluttertoast.showToast(msg: "Please enter a message to deliver.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      borderRadius: BorderRadius.circular(20)),
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
              color: Color(0xff2A2136),
            ),
            child: IconButton(
              disabledColor: Colors.white,
              icon: Icon(Icons.scanner_rounded),
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OCR(),
                    ));
              },
            ),
          ),
          Container(
            width: 40,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff2A2136),
            ),
            child: IconButton(
              disabledColor: Colors.white,
              icon: Icon(Icons.attach_file_rounded),
              color: Colors.white,
              onPressed: () {
                //Navigate the user to the page where the user can attach and view the list of the attached files
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AttachmentScreen()));
              },
            ),
          ),
          Container(
            width: 40,
            margin: EdgeInsets.only(left: 10),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xff2A2136)),
            child: IconButton(
              disabledColor: Colors.white,
              icon: Icon(Icons.send_rounded),
              color: Colors.white,
              onPressed: _enteredMessage.isEmpty ? null : _sendMessage,
            ),
          )
        ],
      ),
    );
  }
}
