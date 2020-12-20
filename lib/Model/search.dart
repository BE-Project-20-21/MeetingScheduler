import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  bool _folded = true;
  String searchQuery;
  var queryResultSet = [];
  var tempSearchStore = [];

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
            color: Colors.blueAccent,
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
                          return nameCard(tempSearchStore[index]["name"]);
                        },
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

  Widget nameCard(String name) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            child: Container(
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
    );
  }

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
  }
}
