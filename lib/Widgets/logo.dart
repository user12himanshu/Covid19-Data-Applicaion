import 'package:covid19_tracker/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Text.rich(TextSpan(
          style: TextStyle(
            color: logoColor,
            fontSize: width * 0.1,
            fontWeight: FontWeight.bold,
          ),
          text: 'C',
          children: <InlineSpan>[
            TextSpan(text: "O", style: TextStyle(color: Colors.amberAccent)),
            TextSpan(text: "VID 19")
          ])),
    );
  }
}
