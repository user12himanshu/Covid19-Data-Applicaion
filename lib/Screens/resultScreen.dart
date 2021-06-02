import 'package:covid19_tracker/Widgets/card.dart';
import 'package:covid19_tracker/Widgets/header.dart';
import 'package:covid19_tracker/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key key, this.searchItem, this.state_dist_data})
      : super(key: key);
  final String searchItem;
  final Map state_dist_data;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool gotData = false;
  bool isLoading = true;
  List keys, values;
  int index;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Header(),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Search Results",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 25,
                ),
                gotData
                    ? DisplayCard(
                        active: values[index]["active"].toString(),
                        infected: values[index]["confirmed"].toString(),
                        recovered: values[index]["recovered"].toString(),
                        death: values[index]["deceased"].toString(),
                        title: widget.searchItem.toUpperCase(),
                      )
                    : Container(
                        margin: EdgeInsets.all(10),
                        decoration:
                            BoxDecoration(border: Border.all(color: textColor)),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "District not found. Please try again!!",
                          style: TextStyle(color: textColor, fontSize: 22),
                        ),
                      )
              ],
            ),
    ));
  }

  void getData() {
    keys = widget.state_dist_data.keys.toList();
    values = widget.state_dist_data.values.toList();
    String lowTest = widget.searchItem.toLowerCase();
    for (var dis in keys) {
      if (widget.searchItem == dis || lowTest == dis.toLowerCase()) {
        index = keys.indexOf(dis);
        setState(() {
          gotData = true;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
