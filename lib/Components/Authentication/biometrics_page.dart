import 'package:flutter/material.dart';
import '../Dashboard/dashboard.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricSetup extends StatefulWidget {
  BiometricSetup({Key key}) : super(key: key);

  @override
  _BiometricSetupState createState() => _BiometricSetupState();
}

class _BiometricSetupState extends State<BiometricSetup> {
  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  bool _authorized = false;
  LocalAuthentication auth = LocalAuthentication();
  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Place you finger on the fingerprint scanner",
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    setState(() {
      _authorized = authenticated;
    });

    if (_authorized) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

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
                        fontSize: 22,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Press Icon below to scan Fingerprint",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.fingerprint_rounded),
                    onPressed: () {
                      _authenticate();
                    },
                    iconSize: 60,
                  ),
                  // SizedBox(
                  //   height: 60,
                  // ),
                  // Text(
                  //   "Use Facial Recognition",
                  //   style: TextStyle(color: Colors.white, fontSize: 18),
                  // ),
                  // IconButton(
                  //     icon: Icon(Icons.fingerprint_rounded), onPressed: () {}),
                  // RaisedButton(
                  //   color: Colors.white,
                  //   disabledColor: Colors.white,
                  //   child: Text("Skip"),
                  //   onPressed: () {
                  //     Navigator.pushReplacement(context,
                  //         MaterialPageRoute(builder: (context) => Dashboard()));
                  //   },
                  // )
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
