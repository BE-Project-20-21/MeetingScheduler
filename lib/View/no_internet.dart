import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import '../main.dart';

class Internet extends StatefulWidget {
  @override
  _InternetState createState() => _InternetState();
}

class _InternetState extends State<Internet> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(
        msg: "The application requires active internet connection to proceed",
        backgroundColor: Color(0xff2A2136),
        textColor: Colors.white);
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.signal_cellular_connected_no_internet_4_bar_rounded,
                  size: 100.0,
                  color: Color(0xff2A2136),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "No Internet!",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xff2A2136),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
