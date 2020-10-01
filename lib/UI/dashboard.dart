import 'package:authentication_app/Model/dashboard_first.dart';
import 'package:authentication_app/Model/dashboard_second.dart';
import 'package:authentication_app/Model/dashboard_third.dart';
import 'package:authentication_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import './manage_schedule.dart';
import 'Home.dart';

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
          textTheme: GoogleFonts.aBeeZeeTextTheme(
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
                      style: GoogleFonts.aBeeZee(
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
                    style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
                  ),
                ),
                new Tab(
                  child: Text("REQUESTED",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ))),
                ),
                new Tab(
                  child: Text(
                    "MY PROFILE",
                    style: GoogleFonts.aBeeZee(
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
enum MenuOption { logout, settings, feedback, manage_schedule }

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
      },
    );
  }

  void logOut(BuildContext context) async {
    final FirebaseAuth authLogOut = FirebaseAuth.instance;
    await authLogOut.signOut();
    print(context);
    Fluttertoast.showToast(msg: "Logging Out!");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }
}

void manageSchedule(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ManageSchedule()));
}
