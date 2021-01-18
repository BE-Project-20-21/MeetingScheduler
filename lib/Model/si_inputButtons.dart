import 'package:authentication_app/Model/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SIInput extends StatelessWidget {
  final String route;
  final String label;
  SIInput(this.route, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(right: 30),
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            if (route == "Search")
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            if (route == "Common Slots") {}
          },
          padding: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(
            label,
            style: TextStyle(
                color: Color(0xFF398AE5),
                letterSpacing: 1,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Metropolis'),
          ),
        ),
      ),
    );
  }
}
