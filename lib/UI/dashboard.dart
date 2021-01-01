import 'package:authentication_app/Model/scheduling_interface.dart';
import 'package:authentication_app/UI/login.dart';
import 'package:authentication_app/Model/dashboard_first.dart';
import 'package:authentication_app/Model/dashboard_second.dart';
import 'package:authentication_app/Model/dashboard_third.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './manage_schedule.dart';
import '../UI/myProfile.dart';

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

//To save the context of the entire Dashboard page (As there are popUp menus present)
BuildContext globalContext;

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
    tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    globalContext = context;
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: GoogleFonts.hammersmithOneTextTheme(
            Theme.of(context).textTheme,
          )),
      home: Material(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
              width: 65,
              height: 65,
              margin: EdgeInsets.only(bottom: 20),
              child: FloatingActionButton(
                onPressed: () {
                  //ADD meeting module
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScheduleInterface(false)));
                },
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
                backgroundColor: Colors.black,
              )),
          appBar: AppBar(
            title: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Dashboard",
                      style: GoogleFonts.hammersmithOne(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              PopupOptionMenu(),
            ],
            bottom: TabBar(
              controller: tabController,
              tabs: <Tab>[
                new Tab(
                  child: Text(
                    "UPCOMING",
                    style: GoogleFonts.hammersmithOne(
                        textStyle: TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
                  ),
                ),
                new Tab(
                  child: Text("REQUESTED",
                      style: GoogleFonts.hammersmithOne(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ))),
                ),
                new Tab(
                  child: Text(
                    "CHATS",
                    style: GoogleFonts.hammersmithOne(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    )),
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: new TabBarView(
              controller: tabController,
              children: <Widget>[
                new DashboardFirst(),
                new DashboardSecond(),
                new DashboardThird(),
              ],
            ),
          ),
        ),
      ),
    );
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
      icon: Icon(
        Icons.menu,
        color: Colors.red,
      ),
      itemBuilder: (BuildContext context1) {
        return <PopupMenuEntry<MenuOption>>[
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    "Manage Schedule",
                    style: TextStyle(color: Colors.black),
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
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.black,
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
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    "My Profile",
                    style: TextStyle(
                      color: Colors.black,
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
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    "Feedback",
                    style: TextStyle(color: Colors.black),
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
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  child: Text(
                    "Logout!",
                    style: TextStyle(
                      color: Colors.black,
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
      },
    );
  }

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
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
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
      print("$slots");
      int len = slots.length;
      print("$len");
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
