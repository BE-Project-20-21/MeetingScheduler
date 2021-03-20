import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gx_file_picker/gx_file_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../Chat/chat_screen.dart';

class AttachmentScreen extends StatefulWidget {
  String _meetingID;
  String subject;
  AttachmentScreen(String meetingID, String subject) {
    this._meetingID = meetingID;
    this.subject = subject;
  }
  AttachmentScreenState createState() => AttachmentScreenState();
}

class AttachmentScreenState extends State<AttachmentScreen> {
  int totalFilesSelected;
  List<File> files = new List<File>();
  Map<String, dynamic> urlMap = new Map<String, dynamic>();

  //Creating an object of ProgressDialog
  ProgressDialog progressDialogFileAttachment;

  void initState() {
    totalFilesSelected = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    //Open the default file explorer of the device
                    pickFiles(context);
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.attach_file_rounded,
                        color: Colors.black,
                      ),
                      Text(
                        'Attach Files',
                        style: TextStyle(
                            color: Color(0xFF614385),
                            letterSpacing: 1,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Metropolis'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 400,
                child: ListView.builder(
                  itemCount: totalFilesSelected,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: fileName(index),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Opacity(
                opacity: totalFilesSelected == 0 ? 0 : 1,
                child: Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () {
                      //Implement method to save the files in storage bucket
                      if (totalFilesSelected != 0) {
                        addFilestoStorageBucket();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please select the files to attach.");
                      }
                    },
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.white,
                    child: Text(
                      'Send Files',
                      style: TextStyle(
                          color: Color(0xFF614385),
                          letterSpacing: 1,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Metropolis'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Method to open the default file explorer and return the list of selected files
  void pickFiles(BuildContext context) async {
    files = await FilePicker.getMultiFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    print("Files: $files");
    print("selects: ${files.length}");
    setState(() {
      totalFilesSelected = files.length;
    });
  }

  //Method to add the selected files to the storage
  void addFilestoStorageBucket() async {
    //Code to show the progress bar
    progressDialogFileAttachment = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialogFileAttachment.style(
      child: Container(
        color: Colors.white,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF7B38C6)),
        ),
        margin: EdgeInsets.all(10.0),
      ),
      message: "Attaching the file(s)!",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 40.0,
      progress: 0.0,
      maxProgress: 100.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0),
      messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0),
    );
    progressDialogFileAttachment.show();
    FirebaseStorage firebaseStorageFileUpload = FirebaseStorage.instance;
    int i;
    for (i = 0; i < files.length; i++) {
      Reference referenceFileUpload = firebaseStorageFileUpload
          .ref()
          .child("Attachments/${widget._meetingID}")
          .child((files[i].path).toString().split("/").last);
      UploadTask uploadTask = referenceFileUpload.putFile(files[i]);
      await uploadTask.whenComplete(() async {
        await referenceFileUpload.getDownloadURL().then((fileUrl) {
          urlMap[((files[i].path).toString().split("/").last)
              .split(".")
              .first] = fileUrl;
        });
      });
    }
    //TODO: Here comes the code to insert the url into realtime database
    addUrlToDatabase();
  }

  //Method to add URL list to the database
  void addUrlToDatabase() async {
    FirebaseDatabase databaseFileAttachments = FirebaseDatabase.instance;
    DatabaseReference referenceFileAttachments = databaseFileAttachments
        .reference()
        .child("attachments")
        .child(widget._meetingID);
    await referenceFileAttachments.update({
      "fileUrl": urlMap,
    }).then((value) {
      showAttachmentsOnChat();
    });
  }

  //Method to naviagte back to chatscreen with all the changes
  void showAttachmentsOnChat() async {
    final user = FirebaseAuth.instance.currentUser;
    int i;
    for (i = 0; i < totalFilesSelected; i++) {
      final userData = await FirebaseFirestore.instance
          .collection('names')
          .doc(user.uid)
          .get();
      FirebaseFirestore.instance.collection(widget._meetingID).add({
        'text':
            "Attached a file: ${(files[i].path).toString().split("/").last}",
        'sentAt': Timestamp.now(),
        'userid': user.uid,
        'username': userData['name'],
        'doc': true,
      });
    }
    progressDialogFileAttachment.hide();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ChatScreen(widget._meetingID, widget.subject)));
  }

  //Widget to desplay each File name
  Widget fileName(int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            (files[index].path).toString().split("/").last,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        color: Colors.white,
        shadowColor: Colors.black,
        elevation: 6.0,
      ),
    );
  }
}
