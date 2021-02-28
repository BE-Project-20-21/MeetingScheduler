import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool uiBoolean = false;
  void initState() {
    getBoolFromSharedPref();
    super.initState();
  }

  Future<bool> getBoolFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final fA = prefs.getBool("fA");
    if (fA == null) {
      await prefs.setBool("fA", false);
    }
    setState(() {
      uiBoolean = fA;
    });
    print("fa: $fA");
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
            Container(
              margin: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Fingerprint Authentication",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: FlutterSwitch(
                      width: 80.0,
                      height: 40.0,
                      valueFontSize: 25.0,
                      toggleSize: 25.0,
                      value: uiBoolean,
                      borderRadius: 30.0,
                      padding: 8.0,
                      activeColor: Color(0xFF7B38C6),
                      showOnOff: false,
                      onToggle: (val) {
                        if (val) {
                          setState(() {
                            uiBoolean = val;
                            setTrue(val);
                          });
                        } else {
                          setState(() {
                            setTrue(val);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
