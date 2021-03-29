import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../Chat/chat_screen.dart';

class OCR extends StatefulWidget {
  String _meetingID;
  String subject;
  OCR(String meetingID, String subject) {
    this._meetingID = meetingID;
    this.subject = subject;
  }

  @override
  _OCRState createState() => _OCRState();
}

class _OCRState extends State<OCR> {
  bool isInitialized = false;

  //Variables required to store the file content
  String appDocPath;
  Map<dynamic, dynamic> urlMap = new Map<dynamic, dynamic>();
  List<OcrText> scannedContent = new List<OcrText>();
  String fileContent;
  String fileName;
  String downloadURL;

  //Variables required to render the UI
  bool documentScanned;

  //Creating an object of ProgressDialog
  ProgressDialog progressDialogFileAttachment;
  @override
  void initState() {
    FlutterMobileVision.start().then((value) {
      isInitialized = true;
    });
    setState(() {
      documentScanned = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () {
                      //Call method to open camera to scan the document
                      _startScan(context);
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
                          Icons.subject_sharp,
                          color: Colors.black,
                        ),
                        Text(
                          'Scan Document',
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
                Visibility(
                  visible: documentScanned ? true : false,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "$fileName.doc",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      color: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 6.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Visibility(
                  visible: documentScanned ? true : false,
                  child: Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () {
                        //Implement method to save the files in storage bucket
                        addFilestoStorageBucket(context);
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
      ),
    );
  }

  //Method to start the camera and begin scanning
  void _startScan(BuildContext context) async {
    try {
      scannedContent =
          await FlutterMobileVision.read(waitTap: true, fps: 5, multiple: true);
      fileContent = "";
      for (OcrText text in scannedContent) {
        print('value is ${text.value}');
        fileContent = fileContent + text.value;
      }
      showRenameCard(context);
    } catch (e) {
      Fluttertoast.showToast(
          msg:
              "We aren't able to scan the document at the moment, please try later.");
      print("error: $e");
    }
  }

  //Method to save the file to the default documents folder of the device
  void saveFileToStorage(BuildContext context) async {
    setState(() {
      documentScanned = true;
    });
    Directory appDocDir = await getExternalStorageDirectory();
    appDocPath = appDocDir.path;
    print("default: $appDocPath");
    new File('$appDocPath/$fileName.doc')
        .writeAsStringSync('Scanned Text:\n$fileContent');

    Navigator.pop(context);
  }

  //Method to show a popup to to let user name the file generated
  void showRenameCard(BuildContext context) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          margin: EdgeInsets.only(left: 40, right: 40, top: 150, bottom: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: renameCardContent(context),
        );
      },
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
    );
  }

  //Method to save the scanned document into firebase storage bucket
  void addFilestoStorageBucket(BuildContext context) async {
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
    //Loading the file from local storage
    File scannedDocument = new File('$appDocPath/$fileName.doc');
    FirebaseStorage firebaseStorageFileUpload = FirebaseStorage.instance;
    Reference referenceFileUpload = firebaseStorageFileUpload
        .ref()
        .child("Attachments/${widget._meetingID}")
        .child(fileName);
    UploadTask uploadTask = referenceFileUpload.putFile(scannedDocument);
    await uploadTask.whenComplete(() async {
      await referenceFileUpload.getDownloadURL().then((fileUrl) {
        downloadURL = fileUrl;
        urlMap[fileName] = downloadURL;
      });
    }).then((value) {
      //Here comes the code to insert the url into realtime database
      addUrlToDatabase();
    });
  }

  //Method to add URL list to the database
  void addUrlToDatabase() async {
    //Code to fetch the list which already exists in the database
    FirebaseDatabase databaseFileAttachments = FirebaseDatabase.instance;
    DatabaseReference referenceFileAttachments = databaseFileAttachments
        .reference()
        .child("attachments")
        .child(widget._meetingID);
    await referenceFileAttachments
        .child("fileUrl")
        .once()
        .then((DataSnapshot dataSnapshot) async {
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> temp = new Map<dynamic, dynamic>();
        temp = dataSnapshot.value;
        print("Retrieved: $temp");
        urlMap.addAll(temp);
        await referenceFileAttachments.update({
          "fileUrl": urlMap,
        });
      } else {
        await referenceFileAttachments.update({
          "fileUrl": urlMap,
        });
      }
    }).then((value) {
      showAttachmentsOnChat();
    });
  }

  //Method to add URL list to the database
  // void addUrlToDatabase() async {
  //   FirebaseDatabase databaseFileAttachments = FirebaseDatabase.instance;
  //   DatabaseReference referenceFileAttachments = databaseFileAttachments
  //       .reference()
  //       .child("attachments")
  //       .child(widget._meetingID);
  //   await referenceFileAttachments.update({
  //     "fileUrl": urlMap,
  //   }).then((value) {
  //     showAttachmentsOnChat();
  //   });
  // }

  //Method to naviagte back to chatscreen with all the changes
  void showAttachmentsOnChat() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('names')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection(widget._meetingID).add({
      'text': "Attached a file: $fileName.doc",
      'sentAt': Timestamp.now(),
      'userid': user.uid,
      'username': userData['name'],
      'doc': true,
    });
    progressDialogFileAttachment.hide();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ChatScreen(widget._meetingID, widget.subject)));
  }

  //Widget to show the text field to name the text file
  Widget renameCardContent(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
            child: Container(
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Please provide a name to the file you just scanned.",
                          style: TextStyle(
                            color: Color(0xFF614385),
                            fontSize: 15.0,
                            fontFamily: 'Metropolis',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(new RegExp('[ -]'))
                          ],
                          cursorColor: Color(0xff3D2F4F),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff3D2F4F)),
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: 'Enter a valid name..',
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff3D2F4F)),
                                  borderRadius: BorderRadius.circular(20)),
                              hintStyle: TextStyle(color: Color(0xff3D2F4F))),
                          onChanged: (value) {
                            fileName = value;
                          },
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            //Call the method to rename the file and save it in the default documents folder
                            if (fileName != null && fileName != "") {
                              saveFileToStorage(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please provide a name for the document!");
                            }
                          },
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            "Rename File",
                            style: TextStyle(
                                color: Colors.green[900],
                                letterSpacing: 1,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Metropolis'),
                          ),
                        ),
                      ),
                    ]))));
  }
}
