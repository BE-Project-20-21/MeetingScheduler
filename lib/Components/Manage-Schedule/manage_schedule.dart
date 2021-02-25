import 'package:date_util/date_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';
import './timeSlotpicker.dart';
import './time_slots.dart';
import '../Dashboard/dashboard.dart';

//Saving the context of manage_schedule.dart page
BuildContext globalContextManageSchedule;

class ManageSchedule extends StatefulWidget {
  @override
  _ManageScheduleState createState() => _ManageScheduleState();
}

class _ManageScheduleState extends State<ManageSchedule> {
  DateTime startTime;
  DateTime endTime;

  FirebaseMessaging _fcm = FirebaseMessaging();
  var pickedDate = new DateTime.now();
  var dateUtility = new DateUtil();
  @override
  void initState() {
    startTime = null;
    endTime = null;
    _fcm.configure(onMessage: (msg) {
      print("Onmessage: $msg");
      notificationSnackbar(msg);
      return;
    }, onLaunch: (msg) {
      print("Onlaunch: $msg");
      return;
    }, onResume: (msg) {
      print("Onresume: $msg");
      return;
    });
    super.initState();
  }

  //Variable required to handle the UI color of the button
  bool pressed = false;

  //Method to show data as snackbar when notifications arrive when app is running
  void notificationSnackbar(dynamic msg) {
    Map<dynamic, dynamic> notification = new Map<dynamic, dynamic>();
    notification = msg["notification"];
    displayNotificationSnackbar(notification["title"]);
  }

  //Method to show notification as a popup
  void displayNotificationSnackbar(String title) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          margin: EdgeInsets.only(left: 40, right: 40, top: 150, bottom: 220),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: notificationContent(title),
        );
      },
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 1000),
    );
    print("printed");
  }

  //Method to return the wodgertr for the popup of the notification
  Widget notificationContent(dynamic subject) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.info_outline_rounded,
                color: Colors.red[900],
                size: 40.0,
              ),
              Text(
                "You have a new meeting scheduled, please check the dashboard to view the newly scheduled meeting.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Notification: New $subject",
                style: TextStyle(
                  color: Color(0xFF7B38C6),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Container(
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            //Code to navigate the user to the dashboard
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Dashboard(),
                              ),
                              (route) => false,
                            );
                          },
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            "Goto Meeting",
                            style: TextStyle(
                                color: Colors.green[900],
                                letterSpacing: 1,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Metropolis'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      child: Container(
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            //Code to dismiss the notification card
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            "Dismiss popup",
                            style: TextStyle(
                                color: Colors.red[900],
                                letterSpacing: 1,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Metropolis'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    globalContextManageSchedule = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Manage Schedule",
      theme:
          ThemeData(fontFamily: 'Metropolis', dividerColor: Colors.transparent),
      home: Material(
        child: Scaffold(
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
                      'My Schedule',
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
            child: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ExpansionTile(
                          maintainState: true,
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          title: Row(
                            children: [
                              Text(
                                  "${newDates(0).day}/${newDates(0).month}/${newDates(0).year}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                              SizedBox(
                                width: 20,
                              ),
                              Text("${DateFormat('EEEE').format(newDates(0))}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(pickedDate)
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          maintainState: true,
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          title: Row(
                            children: [
                              Text(
                                "${newDates(1).day}/${newDates(1).month}/${newDates(1).year}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(1))}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(1))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          maintainState: true,
                          title: Row(
                            children: [
                              Text(
                                "${newDates(2).day}/${newDates(2).month}/${newDates(2).year}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(2))}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(2))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          maintainState: true,
                          title: Row(
                            children: [
                              Text(
                                "${newDates(3).day}/${newDates(3).month}/${newDates(3).year}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(3))}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(3))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          maintainState: true,
                          title: Row(
                            children: [
                              Text(
                                "${newDates(4).day}/${newDates(4).month}/${newDates(4).year}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(4))}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(4))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          maintainState: true,
                          title: Row(
                            children: [
                              Text(
                                "${newDates(5).day}/${newDates(5).month}/${newDates(5).year}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(5))}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(5))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          maintainState: true,
                          title: Row(
                            children: [
                              Text(
                                "${newDates(6).day}/${newDates(6).month}/${newDates(6).year}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${DateFormat('EEEE').format(newDates(6))}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            TimeSlotPickerMatrix(DateFormat('EEEE')
                                .format(newDates(6))
                                .toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Container(
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () {
                                submit();
                              },
                              padding: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Colors.white,
                              child: Text(
                                "Submit Schedule",
                                style: TextStyle(
                                    color: Color(0xFF614385),
                                    letterSpacing: 1,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Metropolis'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime newDates(int i) {
    var newDate = Jiffy(pickedDate).add(days: i);
    return newDate;
  }

  //Method to trigger methods on time_slots.dart file to validate and submit the entire schedule
  void submit() {
    TimeSlots(null, null, true);
  }
}
