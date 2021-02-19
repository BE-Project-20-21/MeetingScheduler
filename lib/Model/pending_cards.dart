import 'package:authentication_app/UI/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/mailer.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../Credentials/mailing_facility.dart';

//Creating an object of ProgressDialog
ProgressDialog progressDialogMeetingCard;

class PendingCards extends StatefulWidget {
  String _meetingID;
  PendingCards(String meetingID) {
    this._meetingID = meetingID;
  }

  @override
  _PendingCardsState createState() => _PendingCardsState();
}

class _PendingCardsState extends State<PendingCards> {
  //Vartiables required to show data on the popup card
  String setBy;
  String members;
  Map<dynamic, dynamic> temp = new Map<dynamic, dynamic>();
  List<String> emailIds = new List<String>();
  String uidFinal;

  //Variable to control the visiblity of the "accept" and "reject" button
  bool showButtons = true;

  @override
  void initState() {
    temp = pendingMeetings[widget._meetingID];
    String memberList =
        temp["Members"].substring(1, temp["Members"].length - 1);
    print("emailList: $memberList");
    emailIds = memberList.split(", ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    //Code to decide if to show the buttons on the meeting card
    //Fetching the uid of the current user
    FirebaseAuth authUidFinal = FirebaseAuth.instance;
    User userUIDFinal = authUidFinal.currentUser;
    uidFinal = userUIDFinal.uid.toString();
    //checking if the meeting is set by the current user
    if (setBy != uidFinal) {
      if (temp[uidFinal] == "pending") {
        showButtons = true;
      } else {
        showButtons = false;
      }
    } else {
      showButtons = false;
    }
    progressDialogMeetingCard.hide();

    //Calling the method to show the cards
    showCard(context);
  }

  void showCard(BuildContext context) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
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
              Visibility(
                visible: showButtons ? true : false,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Container(
                          child: RaisedButton(
                            elevation: 5.0,
                            onPressed: () {
                              //Call the Method to handle all the workings on pressing the accept button
                              meetingAccepted(context);
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
                              //Call the Method to handle all the workings on pressing the reject button
                              meetingRejected(context);
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Method to carry the changes in database when the user accepts the meeting
  void meetingAccepted(BuildContext context) async {
    //Code to show the progress bar
    ProgressDialog progressDialogMeetingAccepted;
    progressDialogMeetingAccepted = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialogMeetingAccepted.style(
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
    progressDialogMeetingAccepted.show();

    //Changing the status of the user in database
    //Code to make changes on database
    FirebaseDatabase databaseMeetingAccepted = FirebaseDatabase.instance;
    DatabaseReference referenceMeetingAccepted = databaseMeetingAccepted
        .reference()
        .child("meetings")
        .child(widget._meetingID);

    //Altering the varibles which are needed to be updated
    int acceptance;
    int rejects;
    await referenceMeetingAccepted
        .child("Accepted")
        .once()
        .then((DataSnapshot dataSnapshot) {
      acceptance = dataSnapshot.value;
      acceptance = acceptance + 1;
    });
    await referenceMeetingAccepted
        .child("Rejected")
        .once()
        .then((DataSnapshot dataSnapshot) {
      rejects = dataSnapshot.value;
    });

    //Code to make changes on database
    referenceMeetingAccepted = databaseMeetingAccepted
        .reference()
        .child("meetings")
        .child(widget._meetingID);
    await referenceMeetingAccepted.update({
      uidFinal: "accepted",
      "Accepted": acceptance,
    }).then((value) {
      setState(() {
        showButtons = false;
      });
    }).then((value) async {
      //Checking whether this accpetance changes the status of the meeting
      progressDialogMeetingAccepted.hide();
      Fluttertoast.showToast(msg: "You have successfully accpeted the Meeting");
      //If the decision is the (meeting-status) deciding factor
      if ((acceptance + rejects).toString() ==
          temp["total-members"].toString()) {
        if (rejects == 0) {
          //Here goes the code to change the meeting status and to send automated email to the members
          await referenceMeetingAccepted
              .update({"status": "confirmed-meeting"});
          //IMPLEMENT AUTOMATED EMAIL TO ALL THE MEMBERS AND THEN CREATE A CHAT GROUP
          sendConfirmationEmail(context);
        } else {
          //Here goes the code to send a mail saying the meet cannot be performed due to rejects and delete the meeting entry from the databse (TODO)
          await referenceMeetingAccepted.update({"status": "canceled-meeting"});
          //IMPLEMENT AUTOMATED EMAIL TO ALL THE MEMBERS
          sendCancellationEmail(context);
        }
      }
      //If the decision is not the (meeting-status) deciding factor
      else {
        //Code to navigate back to dashboard and apply the changes there
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Dashboard(),
          ),
          (route) => false,
        );
      }
    });
  }

  //Method to send confirmation email to all the members os the meeting
  sendConfirmationEmail(BuildContext context) async {
    //Code to show the progress bar
    ProgressDialog progressDialogMeetingConfirmed;
    progressDialogMeetingConfirmed = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialogMeetingConfirmed.style(
      child: Container(
        color: Colors.white,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF7B38C6)),
        ),
        margin: EdgeInsets.all(10.0),
      ),
      message: "Meeting has been confirmed!",
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
    progressDialogMeetingConfirmed.show();

    //Fetching the emailID of all the members
    List emailList = new List();
    FirebaseDatabase databaseEmail = FirebaseDatabase.instance;
    DatabaseReference referenceEmail = databaseEmail.reference().child("users");
    int i;
    for (i = 0; i < emailIds.length; i++) {
      await referenceEmail
          .child(emailIds[i])
          .child("email")
          .once()
          .then((DataSnapshot dataSnapshot) {
        emailList.add(dataSnapshot.value);
      });
    }

    final smtpServer = gmail(mailingEmail, mailingPassword);
    final message = Message()
      ..from = Address(mailingEmail)
      ..recipients.addAll(emailList)
      ..subject = "Meeting Confirmartion!"
      ..html =
          "<h1>Hi, This is your Meeting Scheduler App</h1>\n<p>Your Meeting has been approved and scheduled!</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Fluttertoast.showToast(
          msg: "You will recieve a confirmation email shortly");
    } on MailerException catch (e) {
      print('Message not sent.');
      print("error: $e");
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    progressDialogMeetingConfirmed.hide();

    //Code to navigate back to dashboard and apply the changes there
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Dashboard(),
      ),
      (route) => false,
    );
  }

  //Method to send cancelation email to all the members
  void sendCancellationEmail(BuildContext context) async {
    //Code to show the progress bar
    ProgressDialog progressDialogMeetingCancelled;
    progressDialogMeetingCancelled = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialogMeetingCancelled.style(
      child: Container(
        color: Colors.white,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF7B38C6)),
        ),
        margin: EdgeInsets.all(10.0),
      ),
      message: "Sending your response",
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
    progressDialogMeetingCancelled.show();

    //Fetching the emailID of all the members
    List emailList = new List();
    FirebaseDatabase databaseEmail = FirebaseDatabase.instance;
    DatabaseReference referenceEmail = databaseEmail.reference().child("users");
    int i;
    for (i = 0; i < emailIds.length; i++) {
      await referenceEmail
          .child(emailIds[i])
          .child("email")
          .once()
          .then((DataSnapshot dataSnapshot) {
        emailList.add(dataSnapshot.value);
      });
    }

    final smtpServer = gmail(mailingEmail, mailingPassword);
    final message = Message()
      ..from = Address(mailingEmail)
      ..recipients.addAll(emailList)
      ..subject = "Meeting request Denied/"
      ..html =
          "<h1>Hi, This is your Meeting Scheduler App</h1>\n<p>Your Meeting request has been denied. Please check back later with alternate time-slots</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Fluttertoast.showToast(msg: "Thwe Meeting has been cancelled!");
    } on MailerException catch (e) {
      print('Message not sent.');
      print("error: $e");
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    progressDialogMeetingCancelled.hide();

    //Code to navigate back to dashboard and apply the changes there
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Dashboard(),
      ),
      (route) => false,
    );
  }

  //Method to implement what happens when the user clicks on the reject button
  void meetingRejected(BuildContext context) async {
    //Code to show the progress bar
    ProgressDialog progressDialogMeetingRejected;
    progressDialogMeetingRejected = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialogMeetingRejected.style(
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
    progressDialogMeetingRejected.show();

    //Changing the status of the user in database
    //Code to make changes on database
    FirebaseDatabase databaseMeetingAccepted = FirebaseDatabase.instance;
    DatabaseReference referenceMeetingAccepted = databaseMeetingAccepted
        .reference()
        .child("meetings")
        .child(widget._meetingID);

    //Altering the varibles which are needed to be updated
    int acceptance;
    int rejects;
    await referenceMeetingAccepted
        .child("Accepted")
        .once()
        .then((DataSnapshot dataSnapshot) {
      acceptance = dataSnapshot.value;
    });
    await referenceMeetingAccepted
        .child("Rejected")
        .once()
        .then((DataSnapshot dataSnapshot) {
      rejects = dataSnapshot.value;
      rejects = rejects + 1;
    });

    //Code to make changes on database
    referenceMeetingAccepted = databaseMeetingAccepted
        .reference()
        .child("meetings")
        .child(widget._meetingID);
    await referenceMeetingAccepted.update({
      uidFinal: "rejected",
      "Rejected": rejects,
    }).then((value) {
      setState(() {
        showButtons = false;
      });
    }).then((value) async {
      //Checking whether this accpetance changes the status of the meeting
      progressDialogMeetingRejected.hide();
      Fluttertoast.showToast(
          msg: "You have successfully rejected forthe Meeting");
      //If the decision is the (meeting-status) deciding factor
      if ((acceptance + rejects).toString() ==
          temp["total-members"].toString()) {
        if (rejects == 0) {
          //Here goes the code to change the meeting status and to send automated email to the members
          await referenceMeetingAccepted
              .update({"status": "confirmed-meeting"});
          //IMPLEMENT AUTOMATED EMAIL TO ALL THE MEMBERS AND THEN CREATE A CHAT GROUP
          sendConfirmationEmail(context);
        } else {
          //Here goes the code to send a mail saying the meet cannot be performed due to rejects and delete the meeting entry from the databse (TODO)
          await referenceMeetingAccepted.update({"status": "canceled-meeting"});
          //IMPLEMENT AUTOMATED EMAIL TO ALL THE MEMBERS
          sendCancellationEmail(context);
        }
      }
      //If the decision is not the (meeting-status) deciding factor
      else {
        //Code to navigate back to dashboard and apply the changes there
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Dashboard(),
          ),
          (route) => false,
        );
      }
    });
  }
}
