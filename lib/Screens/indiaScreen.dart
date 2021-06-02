import 'package:covid19_tracker/Widgets/card.dart';
import 'package:covid19_tracker/Widgets/header.dart';
import 'package:covid19_tracker/Widgets/indiaDrawer.dart';
import 'package:covid19_tracker/api.dart';
import 'package:flutter/material.dart';

class IndiaScreen extends StatefulWidget {
  const IndiaScreen({Key key}) : super(key: key);

  @override
  _IndiaScreenState createState() => _IndiaScreenState();
}

class _IndiaScreenState extends State<IndiaScreen> {
  Map data;
  bool isLoading;
  String infected, active, deaths, recovered;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: IndiaDrawer(),
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Header(),
                      DisplayCard(
                        infected: data["Total Cases_text"],
                        death: data["Total Deaths_text"],
                        recovered: data["Total Recovered_text"],
                        active: (int.parse(infected.replaceAll(",", "")) -
                                int.parse(deaths.replaceAll(",", "")) -
                                int.parse(recovered.replaceAll(",", "")))
                            .toString(),
                        title: "India Total",
                      )
                    ],
                  )));
  }

  void getData() {
    ApiService.getIndiaData().then((value) {
      data = value;
      setState(() {
        isLoading = false;
      });
      infected = data["Total Cases_text"];
      deaths = data["Total Deaths_text"];
      recovered = data["Total Recovered_text"];
    });
  }
}
