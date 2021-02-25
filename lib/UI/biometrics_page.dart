import 'package:flutter/material.dart';
import '../UI/dashboard.dart';

class BiometricSetup extends StatefulWidget {
  BiometricSetup({Key key}) : super(key: key);

  @override
  _BiometricSetupState createState() => _BiometricSetupState();
}

class _BiometricSetupState extends State<BiometricSetup> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Metropolis',
        dividerColor: Colors.transparent,
      ),
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
                    'Biometric Authentication',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF614385),
                    Color(0xFF516395),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.2, 0.8])),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width),
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.white,
                    disabledColor: Colors.white,
                    child: Text("Skip"),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    },
                  )
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
