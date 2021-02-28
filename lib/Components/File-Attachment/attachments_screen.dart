import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gx_file_picker/gx_file_picker.dart';

class AttachmentScreen extends StatefulWidget {
  String _meetingID;
  AttachmentScreen(String meetingID) {
    this._meetingID = meetingID;
  }
  AttachmentScreenState createState() => AttachmentScreenState();
}

class AttachmentScreenState extends State<AttachmentScreen> {
  int totalFilesSelected;
  List<File> files = new List<File>();
  List<String> urlList = new List<String>();
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
                height: 600,
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
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    //Implement method to save the files in storage bucket
                    addFilestoStorageBucket();
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
          urlList.add(fileUrl);
        });
      });
    }
    //TODO: Here comes the code to insert the url into realtime database
  }

  //Method to add URL list to the database
  void addUrlToDatabse() {
    //TODO: Call the function to take the user back to the chat screen
    showAttachmentsonChat();
  }

  //Method to naviagte back to chatscreen with all the changes
  void showAttachmentsonChat() {}

  //Widget to desplay each File name
  Widget fileName(int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            files[index].toString().split('/').last,
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
