import 'package:flutter/material.dart';
import 'package:covid19_tracker/constants.dart';
import 'logo.dart';

class Header extends StatefulWidget {
  const Header({Key key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.menu,
                size: width * 0.08,
                color: logoColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
          Logo(),
        ],
      ),
    );
  }
}
