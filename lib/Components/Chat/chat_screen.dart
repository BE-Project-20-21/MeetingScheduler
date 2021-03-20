import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../Chat/new_message.dart';
import '../Chat/messages.dart';
import '../../Components/Chat/documents.dart';

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
                child: PopupOptionMenuChat(_meetingID),
              ),
            ],
          )),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(child: Messages(_meetingID)),
            NewMessage(_meetingID, subject)
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
  String _meetingID;
  PopupOptionMenuChat(String meetingID) {
    this._meetingID = meetingID;
  }

  //Variable required to store the document list
  Map<dynamic, dynamic> documents = new Map<dynamic, dynamic>();

  //Creating an object of ProgressDialog
  ProgressDialog progressDialogDocuments;

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
      onSelected: (selection) {
        if (selection == MenuOption.documents) {
          fetchDocuments(context);
        }
      },
    );
  }

  //Method to fetch all the documents related to the meeting before navigating to the page
  void fetchDocuments(BuildContext context) async {
    //Code to show the progress bar
    progressDialogDocuments = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialogDocuments.style(
      child: Container(
        color: Colors.white,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF7B38C6)),
        ),
        margin: EdgeInsets.all(10.0),
      ),
      message: "Fetching the Documents",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 40.0,
      progress: 0.0,
      maxProgress: 100.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: TextStyle(color: Colors.black, fontSize: 10.0),
      messageTextStyle: TextStyle(color: Colors.black, fontSize: 15.0),
    );
    progressDialogDocuments.show();

    //TODO: FETCH ALL DOCUMENTS RELATED TO THE GROUP ALONG WITH THEIR DOWNLOADABLE LINKS
    FirebaseDatabase databaseDocuments = FirebaseDatabase.instance;
    DatabaseReference referenceDocuments = databaseDocuments
        .reference()
        .child("attachments")
        .child(_meetingID)
        .child("fileUrl");
    await referenceDocuments.once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        documents = dataSnapshot.value;
        print("documentList: $documents");
        progressDialogDocuments.hide();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Documents(documents)));
      } else {
        progressDialogDocuments.hide();
        Fluttertoast.showToast(
            msg: "No documents attached yet!",
            backgroundColor: Color(0xff2A2136),
            textColor: Colors.white);
      }
    });
  }
}
