import 'package:authentication_app/UI/dashboard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:progress_dialog/progress_dialog.dart';

//Creating an object of ProgressDialog
ProgressDialog progressDialogMeetingCard;

class PendingCards extends StatelessWidget {
  String _meetingID;
  PendingCards(String meetingID) {
    this._meetingID = meetingID;
  }

  //Variables required to show data on the cards
  String setBy;
  String members;
  Map<dynamic, dynamic> temp = new Map<dynamic, dynamic>();

  @override
  Widget build(BuildContext context) {
    temp = pendingMeetings[_meetingID];
    return GestureDetector(
      onTap: () {
        //Code to show the Card that contains all the details about the meeting clicked
        popUp(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        width: 380,
        height: 147,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [
                Color(0xFF7B38C6),
                Color(0xFF9543AA),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                temp["subject"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                temp["day"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                "Meeting Timings: ${temp["starTime"]} : 00 - ${temp["endTime"]} : 00",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Method to perform all background retrieving and then show the meeting details card
  void popUp(BuildContext context) async {
    //Code to show the progress bar
    progressDialogMeetingCard = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialogMeetingCard.style(
      child: Container(
        color: Colors.white,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF7B38C6)),
        ),
        margin: EdgeInsets.all(10.0),
      ),
      message: "Fetching the details",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 40.0,
      progress: 0.0,
      maxProgress: 100.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: TextStyle(color: Colors.black, fontSize: 10.0),
      messageTextStyle: TextStyle(color: Colors.black, fontSize: 15.0),
    );
    progressDialogMeetingCard.show();

    //Carrying the retrieving here
    //Retrieving the name of the person who called the meeting
    FirebaseDatabase databaseMeetingCard = FirebaseDatabase.instance;
    DatabaseReference referenceMeetingCard = databaseMeetingCard
        .reference()
        .child("users")
        .child(temp["setBy"])
        .child("name");
    await referenceMeetingCard.once().then((DataSnapshot dataSnapshot) {
      setBy = dataSnapshot.value;
    });
    print("setBy: $setBy");
    progressDialogMeetingCard.hide();

    //Calling the method to show the cards
    showCard(context);
  }

  void showCard(BuildContext context) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(40.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: cardContent(context),
        );
      },
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
    );
  }

  //Widget used to display the details about the meeting on popup
  Widget cardContent(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Meeting Subject: ${temp["subject"]}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Day: ${temp["day"]}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Set by: $setBy",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Start Time: ${temp["starTime"]}:00",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "End Time: ${temp["endTime"]}:00",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: Container(
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {
                          //Call the Method to handle all the workings on pressing the accept button
                        },
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        child: Text(
                          "Accept",
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
                          //Call the Method to handle all the workings on pressing the accept button
                        },
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        child: Text(
                          "Reject",
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
            ],
          ),
        ),
      ),
    );
  }
}
