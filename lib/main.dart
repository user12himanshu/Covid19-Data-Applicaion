import 'package:covid19_tracker/api.dart';
import 'package:flutter/material.dart';
import 'Models/states.dart';
import 'package:covid19_tracker/Screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19 Tracker',
      home: HomePage(),
    );
  }
}
