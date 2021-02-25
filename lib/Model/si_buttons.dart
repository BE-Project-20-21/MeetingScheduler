import 'package:flutter/material.dart';

class SIButtons extends StatelessWidget {
  const SIButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {},
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.white,
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Color(0xFF398AE5),
                  letterSpacing: 1,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 30),
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {},
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.white,
              child: Text(
                'Confirm',
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
    );
  }
}
