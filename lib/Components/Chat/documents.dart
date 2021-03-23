import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Documents extends StatefulWidget {
  Map<dynamic, dynamic> _documents = new Map<dynamic, dynamic>();
  Documents(Map<dynamic, dynamic> documents) {
    this._documents = documents;
  }
  DocumentState createState() => DocumentState();
}

class DocumentState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    print("Map: ${widget._documents}");
    // final height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: 400,
                    child: ListView.builder(
                      itemCount: widget._documents.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: eachDocument(index),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Widget to show each document tab
  Widget eachDocument(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget._documents.keys.elementAt(index),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {
                  //Call the method to download the respective file
                  downloadFile(
                      widget._documents.keys.elementAt(index), context);
                },
                icon: Icon(
                  Icons.download_rounded,
                  color: Color(0xff2A2136),
                ),
              ),
            ],
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

  //Method to download the file
  void downloadFile(String fileName, BuildContext context) async {
    print("filename: $fileName");
    String downloadUrl = widget._documents[fileName];
    print("url: $downloadUrl");
    //Creating a file to store the document in
    Directory appDocDirDownload;
    appDocDirDownload = await getExternalStorageDirectory();
    FirebaseStorage storageDownloadFile = FirebaseStorage.instance;
    Reference referenceDownloadFile =
        storageDownloadFile.refFromURL(downloadUrl);
    print("reference: ${referenceDownloadFile.fullPath}");
    int length = appDocDirDownload.toString().length;
    File tempFile =
        new File("${appDocDirDownload.path}/${referenceDownloadFile.name}");
    DownloadTask downloadTask = referenceDownloadFile.writeToFile(tempFile);
    downloadTask.whenComplete(() {
      print("download complete!");
      Fluttertoast.showToast(
          msg: "Download Complete",
          backgroundColor: Color(0xff2A2136),
          textColor: Colors.white);
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text('Show Snackbar'),
      //   duration: Duration(seconds: 3),
      // ));
    });
  }
}
