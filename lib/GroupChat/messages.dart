import '../GroupChat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  String _meetingID;

  Messages(String meetingID) {
    this._meetingID = meetingID;
  }

  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(_meetingID)
            .orderBy('sentAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshot.data.docs;
          return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                    chatDocs[index]['text'],
                    chatDocs[index]['userid'] == userid,
                    ValueKey(chatDocs[index].documentID),
                    chatDocs[index]['username'],
                  ));
        });
  }
}
