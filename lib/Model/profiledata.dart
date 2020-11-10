import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class ProfileData {
  String name, email;
  ProfileData(this.name, this.email);
}
