import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gx_file_picker/gx_file_picker.dart';

class AttachmentScreen extends StatefulWidget {
  AttachmentScreenState createState() => AttachmentScreenState();
}

class AttachmentScreenState extends State<AttachmentScreen> {
  int totalFilesSelected;
  List<File> files = new List<File>();
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

  //Widget to desplay each File name
  Widget fileName(int index) {
    return Container(
      child: Text(files[index].toString().split('/').last),
    );
  }
}
