import 'package:covid19_tracker/Screens/indiaScreen.dart';
import 'package:covid19_tracker/Widgets/logo.dart';
import 'package:covid19_tracker/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String url = "http://himanshuagrawal.xyz/";
  void launchURL() async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(child: Logo()),
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.dharmachakra,
                    color: Colors.black87,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "State and District Data",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: textColor),
                  ),
                ],
              ),
            )),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return IndiaScreen();
            }));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.globeAsia, color: Colors.black87),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "India Data",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: textColor),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 60),
          child: TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.all(10),
                backgroundColor: Color(0xff7c4dff),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: launchURL,
            child: Text(
              "About Me",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ),
        )
      ],
    ));
  }
}
