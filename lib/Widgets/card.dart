import 'package:covid19_tracker/constants.dart';
import 'package:flutter/material.dart';

class DisplayCard extends StatelessWidget {
  final String title, active, death, recovered, infected;

  const DisplayCard(
      {Key key,
      this.title,
      this.active,
      this.death,
      this.recovered,
      this.infected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: width - 30,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(blurRadius: 3, color: Colors.grey, spreadRadius: 1)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: textColor,
                  fontSize: width * 0.065,
                  fontWeight: FontWeight.w500),
            ),
            CardRow(
              width: width,
              sColor: sinfectedColor,
              pColor: pinfectedColor,
              category: "Infected",
              cases: infected,
            ),
            Divider(
              color: hrColor,
              thickness: 4,
            ),
            CardRow(
              width: width,
              sColor: sactiveColor,
              pColor: pactiveColor,
              category: "Active",
              cases: active,
            ),
            Divider(
              color: hrColor,
              thickness: 4,
            ),
            CardRow(
              width: width,
              sColor: sdeathsColor,
              pColor: pdeathsColor,
              category: "Deaths",
              cases: death,
            ),
            Divider(
              color: hrColor,
              thickness: 4,
            ),
            CardRow(
              width: width,
              sColor: srecoveredColor,
              pColor: precoveredColor,
              category: "Recovered",
              cases: recovered,
            ),
          ],
        ),
      ),
    );
  }
}

class CardRow extends StatelessWidget {
  final double width;
  final String category, cases;
  final Color sColor, pColor;

  const CardRow(
      {Key key,
      this.width,
      this.category,
      this.cases,
      this.sColor,
      this.pColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: sColor,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: pColor,
                  child: CircleAvatar(
                    backgroundColor: sColor,
                    radius: 6,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                category,
                style: TextStyle(
                    color: textColor,
                    fontSize: width * 0.07,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Text(
            cases,
            style: TextStyle(
                color: pColor,
                fontSize: width * 0.07,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
