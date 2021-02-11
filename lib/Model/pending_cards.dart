import 'package:authentication_app/UI/dashboard.dart';
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

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> temp = new Map<dynamic, dynamic>();
    temp = pendingMeetings[_meetingID];
    return GestureDetector(
      onTap: () {
        //Code to show the Card that contains all the details about the meeting clicked
        showCard(context, temp);
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

  void showCard(BuildContext context, Map<dynamic, dynamic> temp) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        //Call the widget that will call show the details about the meeting
        return cardContent(context);
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 1000),
    );
  }

  //Widget used to display the details about the meeting on popup
  Widget cardContent(BuildContext context) {}
}
