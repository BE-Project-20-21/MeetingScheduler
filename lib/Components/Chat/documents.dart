import 'package:flutter/material.dart';

class Documents extends StatefulWidget {
  DocumentState createState() => DocumentState();
}

class DocumentState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
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
                      itemCount: 4,
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
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "Docs",
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
