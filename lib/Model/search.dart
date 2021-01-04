import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UI/scheduling_interface.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  //To declare variables
  bool _folded = true;
  //Variable to store the search query
  String searchQuery;
  //Variable to store tghe output from the database for a particular search query
  var queryResultSet = [];
  var tempSearchStore = [];

  String daySelected = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Search",
      theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.orangeAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.aBeeZeeTextTheme(
            Theme.of(context).textTheme,
          )),
      home: Material(
        color: Colors.blueAccent,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      duration: Duration(microseconds: 400),
                      width: _folded ? 56 : double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.0),
                        color: Colors.white,
                        boxShadow: kElevationToShadow[6],
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 16),
                              child: !_folded
                                  ? TextField(
                                      onChanged: (query) {
                                        searchQuery = query;
                                        searchUsers(searchQuery);
                                      },
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                          color: Colors.blue,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            child: Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(_folded ? 32 : 0),
                                  topRight: Radius.circular(32),
                                  bottomLeft: Radius.circular(_folded ? 32 : 0),
                                  bottomRight: Radius.circular(32),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(
                                    _folded ? Icons.search : Icons.close,
                                    color: Colors.blue,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _folded = !_folded;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: kElevationToShadow[6],
                      ),
                      margin: EdgeInsets.only(top: 20.0),
                      child: ListView.builder(
                        itemCount: tempSearchStore.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return nameCard(tempSearchStore[index]["name"],
                              tempSearchStore[index]["uid"]);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Text(
                        "Selected Members: $totalSelected",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: kElevationToShadow[6],
                      ),
                      margin: EdgeInsets.only(top: 20.0),
                      child: ListView.builder(
                        itemCount: selectedMembers.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return listedMember(
                              selectedMembers[selectedNames.elementAt(index)],
                              selectedNames.elementAt(index));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {
                          navigateBack();
                        },
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        child: Text(
                          'Proceed!',
                          style: TextStyle(
                            color: Color(0xFF398AE5),
                            letterSpacing: 1,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
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
    );
  }

//Widget to render the list of selected members
  Widget listedMember(String name, String uid) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.all(10.0),
                ),
                GestureDetector(
                  onTap: () {
                    //Here goes the code to delete the user from the list
                    //Calling function to discard members from the list
                    discardMember(uid);
                  },
                  child: Container(
                    color: Colors.white,
                    child: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

//Widget to render each name slots which appears on entering a particular search query
  Widget nameCard(String name, String uid) {
    bool selected = false;
    int keepCount = 0;
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = true;
                  keepCount++;
                });
                if (keepCount % 2 == 0) {
                  setState(() {
                    selected = false;
                  });
                } else {
                  //Calling function to add members to the list
                  addMember(name, uid);
                }
              },
              child: Container(
                color: selected ? Colors.grey : Colors.white,
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
                padding: EdgeInsets.all(10.0),
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

//Method to implement searching members for the meeting
  void searchUsers(String query) async {
    if (query.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    if (queryResultSet.length == 0 && query.length == 1) {
      await FirebaseFirestore.instance
          .collection("names")
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (int i = 0; i < querySnapshot.docs.length; ++i) {
          queryResultSet.add(querySnapshot.docs[i].data());
        }
        tempSearchStore = [];
        queryResultSet.forEach((element) {
          if (element["name"].startsWith(query.substring(0, 1).toUpperCase())) {
            setState(() {
              tempSearchStore.add(element);
            });
          }
        });
      });
    } else {
      var formattedQuery =
          query.substring(0, 1).toUpperCase() + query.substring(1);
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element["name"].startsWith(formattedQuery)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
    print("map: $tempSearchStore");
  }

//Method to add member to the list
  void addMember(String name, String uid) {
    if (totalSelected < 4) {
      selectedNames.add(uid);
      selectedMembers[uid] = name;
      membersNames.add(name);
      totalSelected++;
    } else {
      Fluttertoast.showToast(msg: "Maximum number of members reacehed!");
    }
    print("selects: $selectedMembers");
  }

//Method to remove member from the list
  void discardMember(String uid) {
    membersNames.remove(selectedMembers[uid]);
    setState(() {
      selectedNames.remove(uid);
      selectedMembers.remove(uid);
    });
    totalSelected--;
  }

//Method to implement free slots fetching from the database

  //Method to navigate back to scheduling interface
  void navigateBack() {
    if (totalSelected > 0) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ScheduleInterface(true)));
    } else {
      Fluttertoast.showToast(
          msg: "Please choose the members for the meeting before proceeding!");
    }
  }
}
