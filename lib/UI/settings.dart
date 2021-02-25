import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Settings extends StatefulWidget {
  Future<bool> getBoolFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final fA = prefs.getBool("fA");
    if (fA == null) {
      await prefs.setBool("fA", false);
    }
    return fA;
  }

  Future<void> setTrue(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("fA", value);
    bool sharedPrefvariable = await getBoolFromSharedPref();
    print(sharedPrefvariable);
  }

  Future<void> setFalse(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("fA", value);
    bool sharedPrefvariable = await getBoolFromSharedPref();
    print(sharedPrefvariable);
  }

  Future<bool> _setBoolinSharedPref(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("fA", value);
  }

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Scheduling Interface",
      theme: ThemeData(
          fontFamily: 'Metropolis',
          dividerColor: Colors.transparent,
          primaryColor: Color(0xFF7B38C6)),
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
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Fingerprint Authentication",
                  ),
                ),
                RaisedButton(
                  child: Text("On"),
                  onPressed: () {
                    widget.setTrue(true);
                  },
                ),
                RaisedButton(
                    child: Text("Off"),
                    onPressed: () {
                      widget.setFalse(false);
                    })
              ],
            ),
          ]),
        )),
      ),
    );
  }
}
