import 'package:covid19_tracker/Screens/resultScreen.dart';
import 'package:covid19_tracker/Widgets/card.dart';
import 'package:covid19_tracker/Widgets/drawer.dart';
import 'package:covid19_tracker/Widgets/header.dart';
import 'package:covid19_tracker/api.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/Models/states.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading, gotData;
  States stateData;
  List<String> states = [];
  String selectedItem = "Andhra Pradesh";
  int selectedItemIndex = 1;
  String confirmed, recovered, deaths, active;
  int items;
  Map districtData, state_dist_data;
  List keys, values;
  String d_confirmed, d_deaths, d_active, d_recovered;
  final myController = TextEditingController();

  // d for districts data

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotData = false;
    isLoading = true;
    getDistrictDataApi();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(physics: ScrollPhysics(), children: [
                Column(
                  //Main Coloumn Starts here
                  children: [
                    Header(),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Color(0xffd8e0e8),
                              borderRadius: BorderRadius.circular(38)),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(38)),
                            child: DropdownButton<String>(
                              focusColor: Colors.white,
                              items: states.map((String dropDownStringItem) {
                                return DropdownMenuItem(
                                    child: Text(dropDownStringItem),
                                    value: dropDownStringItem);
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  selectedItem = newValueSelected;
                                  selectedItemIndex = getIndex();
                                  getStateData();
                                  state_dist_data = districtData[selectedItem]
                                      ["districtData"];
                                  keys = state_dist_data.keys.toList();
                                  values = state_dist_data.values.toList();
                                });
                              },
                              value: selectedItem,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    getStatesWidget("Total"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "All Districts",
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child: TextField(
                            controller: myController,
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 14.0),
                                suffixIcon: Material(
                                    elevation: 2.0,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ResultScreen(
                                            searchItem: myController.text,
                                            state_dist_data: state_dist_data,
                                          );
                                        }));
                                      },
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      ),
                                    )),
                                border: InputBorder.none,
                                hintText: "Search District")),
                      ),
                    ),
                    getDistrictListView()
                  ],
                ),
              ]),
      ),
    );
  }

  void getDropDown() {
    for (int i = 0; i < 36; i++) {
      states.add(stateData.data.regional[i].loc);
    }
  }

  void getStatesData() {
    ApiService.getState().then((state) {
      stateData = state;
      getDropDown();
      setState(() {
        isLoading = false;
        getStateData();
      });
    });
  }

  void getDistrictDataApi() {
    ApiService.getDistData(selectedItem).then((value) {
      keys = value[0];
      values = value[1];
      districtData = value[2];
      state_dist_data = districtData[selectedItem]["districtData"];
      getStatesData();
    });
  }

  // ignore: missing_return
  int getIndex() {
    for (int i = 0; i < 36; i++) {
      if (selectedItem == stateData.data.regional[i].loc) {
        return i;
      }
    }
  }

  void getStateData() {
    confirmed = stateData.data.regional[selectedItemIndex].confirmedCasesIndian
        .toString();
    deaths = stateData.data.regional[selectedItemIndex].deaths.toString();
    active = (stateData.data.regional[selectedItemIndex].confirmedCasesIndian -
            stateData.data.regional[selectedItemIndex].discharged)
        .toString();
    recovered =
        stateData.data.regional[selectedItemIndex].discharged.toString();
  }

  Widget getStatesWidget(String title) {
    if (confirmed != "Null") {
      return DisplayCard(
        active: active,
        infected: confirmed,
        death: deaths,
        recovered: recovered,
        title: title,
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  void getDistrictWidgetData(int index) {
    d_confirmed = values[index]["confirmed"].toString();
    d_deaths = values[index]["deceased"].toString();
    d_active = values[index]["active"].toString();
    d_recovered = values[index]["recovered"].toString();
  }

  Widget getDistrictWidget(int index) {
    return DisplayCard(
      active: d_active,
      infected: d_confirmed,
      death: d_deaths,
      recovered: d_recovered,
      title: keys[index],
    );
  }

  Widget getDistrictListView() {
    if (true) {
      return Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(15),
            scrollDirection: Axis.vertical,
            itemCount: keys.length,
            itemBuilder: (BuildContext context, int index) {
              getDistrictWidgetData(index);
              return getDistrictWidget(index);
            }),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  void changeData() {
    state_dist_data = districtData[selectedItem]["districtData"];
    keys = state_dist_data.keys.toList();
    values = state_dist_data.values.toList();
  }
}
