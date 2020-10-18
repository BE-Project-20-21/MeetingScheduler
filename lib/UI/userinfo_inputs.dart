import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class UserInfoInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Firebase.initializeApp();
  }
}
