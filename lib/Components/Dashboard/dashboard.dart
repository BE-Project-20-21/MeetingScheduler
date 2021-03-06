import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';
import './upcoming.dart';
import './pending.dart';
import '../Authentication/login.dart';
import '../Manage-Schedule/manage_schedule.dart';
import '../Profile/my_profile.dart';
import '../Chat/groupchat.dart';
import '../Settings/settings.dart';
import '../Scheduling-Interface/scheduling_interface.dart';

//Variables required to store the meeting and their details respectively
List<String> allMeetings = new List<String>();
List<String> pendingList = new List<String>();
List<String> upcomingList = new List<String>();

Map<String, Map<dynamic, dynamic>> pendingMeetings =
    new Map<String, Map<dynamic, dynamic>>();
Map<String, Map<dynamic, dynamic>> upcomingMeetings =
    new Map<String, Map<dynamic, dynamic>>();

//The map for each day containing the time slots, and boolean value for each slot; true: free, false: occupied.
var sundayMap = new Map<int, bool>();
var mondayMap = new Map<int, bool>();
var tuesdayMap = new Map<int, bool>();
var wednesdayMap = new Map<int, bool>();
var thursdayMap = new Map<int, bool>();
var fridayMap = new Map<int, bool>();
var saturdayMap = new Map<int, bool>();

//Creating an object of ProgressDialog
ProgressDialog progressDialogSchedule;
ProgressDialog progressDialogMeeting;

//To save the context of the entire Dashboard page (As there are popUp menus present)
BuildContext globalContext;

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    Firebase.initializeApp();
    allMeetings.clear();
    pendingList.clear();
    upcomingList.clear();
    pendingMeetings.clear();
    upcomingMeetings.clear();
    fetchMeetingsDetails();
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
    tabController = new TabController(vsync: this, length: 3);
  }

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

  //Method to fetch the list of meetinhs the user is part of and later fetch the data for each meeting
  void fetchMeetingsDetails() async {
    //Code to show the progress bar
    progressDialogMeeting = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialogMeeting.style(
      child: Container(
        color: Colors.white,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF7B38C6)),
        ),
        margin: EdgeInsets.all(10.0),
      ),
      message: "Gathering your Meetings!",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 40.0,
      progress: 0.0,
      maxProgress: 100.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0),
      messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0),
    );
    progressDialogMeeting.show();

    //Getting the authentication reference and getting the current user data
    FirebaseAuth authFetchMeetings = FirebaseAuth.instance;
    User userFetchMeetings = authFetchMeetings.currentUser;
    String uidFetchMeetings = userFetchMeetings.uid.toString();
    FirebaseDatabase databaseFetchMeetings = FirebaseDatabase.instance;
    DatabaseReference referenceFetchMeetings = databaseFetchMeetings
        .reference()
        .child("meetings-list")
        .child(uidFetchMeetings);
    await referenceFetchMeetings.once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        dataSnapshot.value
            .forEach((meetingID, irrelevant) => allMeetings.add(meetingID));
      } else {
        Fluttertoast.showToast(msg: "No meetings to show!");
      }
    });
    print("ALL MEETINGS: $allMeetings");

    //Now we have a list of meetings, now we seperate pending and confirmed ones and save details about each in maps and pass them to respective dashboard tab
    int i;
    for (i = 0; i < allMeetings.length; i++) {
      referenceFetchMeetings = databaseFetchMeetings
          .reference()
          .child("meetings")
          .child(allMeetings[i]);
      await referenceFetchMeetings.once().then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.value["status"] == "pending-meeting") {
          setState(() {
            pendingMeetings[allMeetings[i]] = dataSnapshot.value;
            pendingList.add(allMeetings[i]);
          });
        } else if (dataSnapshot.value["status"] == "confirmed-meeting") {
          setState(() {
            upcomingMeetings[allMeetings[i]] = dataSnapshot.value;
            upcomingList.add(allMeetings[i]);
          });
        }
      });
    }
    print("Pending Meetings: $pendingMeetings");
    print("Upcoming Meetings: $upcomingMeetings");

    progressDialogMeeting.hide();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Metropolis'),
      home: Material(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(bottom: 20),
              child: FloatingActionButton(
                onPressed: () {
                  //ADD meeting module
                  //Code to clear the global variables
                  selectedMembers.clear();
                  selectedNames.clear();
                  membersNames.clear();
                  commonslots.clear();
                  totalSelected = 0;
                  scheduleMeeting();
                },
                child: Icon(
                  Icons.add,
                  size: 35,
                  color: Color(0xFF516395),
                ),
                backgroundColor: Colors.white,
              )),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: AppBar(
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
                        'Dashboard',
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: PopupOptionMenu(),
                ),
              ],
              bottom: TabBar(
                labelColor: Color(0xFF614385),
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white),
                controller: tabController,
                tabs: <Tab>[
                  new Tab(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: FittedBox(
                        child: Text(
                          "UPCOMING",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Tab(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: FittedBox(
                        child: Text(
                          "PENDING",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Tab(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: FittedBox(
                        child: Text(
                          "CHATS",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
              child: new TabBarView(
                controller: tabController,
                children: <Widget>[
                  DashboardFirst(),
                  DashboardSecond(),
                  GroupChat(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Method to check if user has provided his/her schedule, if yes proceed to scheduling interface
  void scheduleMeeting() async {
    ProgressDialog progressDialog;
    //Code to show the progress bar
    progressDialog = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialog.style(
      child: Container(
        color: Colors.white,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF7B38C6)),
        ),
        margin: EdgeInsets.all(10.0),
      ),
      message: "Gathering the information",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 40.0,
      progress: 0.0,
      maxProgress: 100.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0),
      messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0),
    );
    progressDialog.show();

    //Checking if the user has submitted the schedule
    FirebaseAuth authCheck = FirebaseAuth.instance;
    User userCheck = authCheck.currentUser;
    String uidCheck = userCheck.uid.toString();
    FirebaseDatabase databaseCheck = FirebaseDatabase.instance;
    DatabaseReference referenceCheck =
        databaseCheck.reference().child("schedule").child(uidCheck);
    await referenceCheck.once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value == null) {
        Fluttertoast.showToast(
            msg:
                "Please provide your schedule, and then you can schedule meeting with others!");
        progressDialog.hide();
      } else {
        progressDialog.hide();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ScheduleInterface(false)));
      }
    });
  }
}

//Menu facilitator
enum MenuOption { logout, settings, feedback, manage_schedule, my_profile }

// Class to build the menu
class PopupOptionMenu extends StatelessWidget {
  const PopupOptionMenu({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupMenuButton<MenuOption>(
      icon: Icon(Icons.menu, color: Colors.white),
      itemBuilder: (BuildContext context1) {
        return <PopupMenuEntry<MenuOption>>[
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.calendar_today,
                    color: Color(0xFF614385),
                  ),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    "Manage Schedule",
                    style: TextStyle(
                        color: Color(0xFF614385), fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.all(5),
                )
              ],
            ),
            value: MenuOption.manage_schedule,
          ),
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.settings,
                    color: Color(0xFF614385),
                  ),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      color: Color(0xFF614385),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                ),
              ],
            ),
            value: MenuOption.settings,
          ),
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.account_box,
                    color: Color(0xFF614385),
                  ),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    "My Profile",
                    style: TextStyle(
                      color: Color(0xFF614385),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                ),
              ],
            ),
            value: MenuOption.my_profile,
          ),
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.feedback,
                    color: Color(0xFF614385),
                  ),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    "Feedback",
                    style: TextStyle(
                        color: Color(0xFF614385), fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.all(5),
                ),
              ],
            ),
            value: MenuOption.feedback,
          ),
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.exit_to_app,
                    color: Color(0xFF614385),
                  ),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    "Logout!",
                    style: TextStyle(
                      color: Color(0xFF614385),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                ),
              ],
            ),
            value: MenuOption.logout,
          ),
        ];
      },
      onSelected: (selection) {
        if (selection == MenuOption.logout) {
          logOut(context);
        }
        if (selection == MenuOption.manage_schedule) {
          manageSchedule(globalContext);
        }
        if (selection == MenuOption.my_profile) {
          myProfile(globalContext);
        }
        if (selection == MenuOption.settings) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Settings()));
        }
      },
    );
  }

  //Method to logout the current loggedin user
  void logOut(BuildContext context) async {
    final FirebaseAuth authLogOut = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    await googleSignIn.signOut();
    await authLogOut.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
    Fluttertoast.showToast(msg: "Logging Out!");
  }
}

//Method to retrieve the schedule and have the maps ready to render the UI on manage schedule page
void manageSchedule(BuildContext context) {
  //Code to retrieve the schedule if any and then move to manage schedule page
  //Here Goes the entire code to check if schedule already submitted
  // and if submitted read the schedule from the Database and reflect the schedule on the application
  //Starting the progress bar for the period to gather the already submitted schedule

  //Getting the authentication reference and getting the current user data
  FirebaseAuth authSchedule = FirebaseAuth.instance;
  User userSchedule = authSchedule.currentUser;
  String uidSchedule = userSchedule.uid.toString();

  //Code to show the progress bar
  progressDialogSchedule = new ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: false);
  progressDialogSchedule.style(
    child: Container(
      color: Colors.white,
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF398AE5)),
      ),
      margin: EdgeInsets.all(10.0),
    ),
    message: "Fetching your Schedule!",
    borderRadius: 10.0,
    backgroundColor: Colors.white,
    elevation: 40.0,
    progress: 0.0,
    maxProgress: 100.0,
    insetAnimCurve: Curves.easeInOut,
    progressWidgetAlignment: Alignment.center,
    progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0),
    messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0),
  );
  progressDialogSchedule.show();

  //Code to check whether the schedule exists
  FirebaseDatabase databaseSchedule = new FirebaseDatabase();
  DatabaseReference referenceSchedule =
      databaseSchedule.reference().child("schedule");
  referenceSchedule
      .reference()
      .child(uidSchedule)
      .once()
      .then((DataSnapshot dataSnapshot) {
    if (dataSnapshot.value != null) {
      //Code to load the existing schedule and populate the Maps
      displaySchedule(uidSchedule, context);
    } else {
      progressDialogSchedule.hide();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ManageSchedule()));
    }
  });
}

//Method to display the pre-submitted schedule
void displaySchedule(String uidSchedule, BuildContext context) async {
  //Saving each node containing the day name in the list
  var listDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  //Retrieving schedule from the database and populating the maps
  FirebaseDatabase databaseRetrieveSchdeule = new FirebaseDatabase();
  DatabaseReference referenceRetrieveSchdeule =
      databaseRetrieveSchdeule.reference().child("schedule").child(uidSchedule);
  //Code to retrieve the data from the database
  //Iterating over the list to save the schedule for ith index day in the list from the database to the map for that day
  for (int i = 0; i < listDays.length; i++) {
    await referenceRetrieveSchdeule
        .child(listDays.elementAt(i))
        .once()
        .then((DataSnapshot datasnapshot) {
      List<dynamic> slots = datasnapshot.value;
      //Code to save the entire schedule for a day into the map and then shift it to the schedule map
      for (int j = 0; j < slots.length; j++) {
        if (listDays.elementAt(i) == "Sunday") {
          if (slots.elementAt(j) == "true") {
            sundayMap[j] = true;
          } else {
            sundayMap[j] = false;
          }
        } else if (listDays.elementAt(i) == "Monday") {
          if (slots.elementAt(j) == "true") {
            mondayMap[j] = true;
          } else {
            mondayMap[j] = false;
          }
        } else if (listDays.elementAt(i) == "Tuesday") {
          if (slots.elementAt(j) == "true") {
            tuesdayMap[j] = true;
          } else {
            tuesdayMap[j] = false;
          }
        } else if (listDays.elementAt(i) == "Wednesday") {
          if (slots.elementAt(j) == "true") {
            wednesdayMap[j] = true;
          } else {
            wednesdayMap[j] = false;
          }
        } else if (listDays.elementAt(i) == "Thursday") {
          if (slots.elementAt(j) == "true") {
            thursdayMap[j] = true;
          } else {
            thursdayMap[j] = false;
          }
        } else if (listDays.elementAt(i) == "Friday") {
          if (slots.elementAt(j) == "true") {
            fridayMap[j] = true;
          } else {
            fridayMap[j] = false;
          }
        } else if (listDays.elementAt(i) == "Saturday") {
          if (slots.elementAt(j) == "true") {
            saturdayMap[j] = true;
          } else {
            saturdayMap[j] = false;
          }
        }
      }
    });
  }
  progressDialogSchedule.hide();
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ManageSchedule()));
}

void myProfile(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
}
