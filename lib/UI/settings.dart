import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

bool isFingerAuthOn = false;

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Scheduling Interface",
      theme:
          ThemeData(fontFamily: 'Metropolis', dividerColor: Colors.transparent),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 30),
                  child: Text(
                    'Settings',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1,
                        fontSize: 33,
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            child: SafeArea(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Fingerprint Authentication",
                ),
              ),
              RaisedButton(
                child: Text("On"),
                onPressed: () {
                  isFingerAuthOn = true;
                  print(isFingerAuthOn);
                },
              ),
              RaisedButton(
                child: Text("Off"),
                onPressed: () {
                  isFingerAuthOn = false;
                  print(isFingerAuthOn);
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
