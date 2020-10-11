import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardThird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 90.0,
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Amar Vijaykumar Singh",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.linkedin,
                              color: Colors.white,
                              size: 15.0,
                            ),
                            Text(
                              " LinkedIn",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            )
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.all(10.0),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            width: double.infinity,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          Container(
              child: Card(
                elevation: 10,
                color: Colors.white.withOpacity(0.7),
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              height: 100,
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 10.0,
              )),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue,
              Colors.blue,
              Colors.deepPurpleAccent,
            ]),
      ),
    );
  }
}
