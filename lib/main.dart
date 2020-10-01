import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'UI/Home.dart';
import 'UI/dashboard.dart';

//To make sure that app has initialized connection with the database.
bool isConnected = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Ensured that app has initialized connection with the database.
  isConnected = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState()  {
    super.initState();
    startTimer();
  }

  startTimer() async{
    var duration = Duration(seconds: 2);
    if (FirebaseAuth.instance.currentUser == null){
      return Timer(duration, route1);
    }
    else{
      return Timer(duration, route2);
    }
  }

  route1(){
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home(),
    ));
  }

  route2(){
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Dashboard(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Authentication App",
      theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.orangeAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.aBeeZeeTextTheme(
            Theme.of(context).textTheme,
          )
      ),
      home: Material(
        child: Container(
          child: SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                  child: Image(
                    image: AssetImage("assets/images/logo1.png"),
                  ),
                  margin: EdgeInsets.all(10.0),
                ),
                  Container(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    margin: EdgeInsets.all(10.0),
                  ),
                  Container(
                    child: Text(
                      "Meeting Scheduler",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
              ],),
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 30.0
              ),
            ),
          ),
        ),
      ),
    );
  }
}

