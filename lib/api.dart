import 'dart:convert';
import 'package:covid19_tracker/Models/states.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const statesUrl = "https://api.rootnet.in/covid19-in/stats/latest";
  static const districtUrl =
      "https://api.covid19india.org/state_district_wise.json";
  static const indiaUrl = "https://covid-19.dataflowkit.com/v1/india";

  static Future<States> getState() async {
    try {
      final response = await http.get(Uri.parse(statesUrl));
      if (response.statusCode == 200) {
        final States states = stateFromJson(response.body);
        return states;
      } else {
        return States();
      }
    } catch (e) {
      return States();
    }
  }

  static Future<List> getDistData(String selectedItem) async {
    try {
      final response = await http.get(Uri.parse(districtUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> distData = jsonDecode(response.body);
        Map state_dist_data = distData[selectedItem]["districtData"];
        List keys = state_dist_data.keys.toList();
        List values = state_dist_data.values.toList();
        return [keys, values, distData];
      } else {
        print("Error: Response code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<Map> getIndiaData() async {
    try {
      final response = await http.get(Uri.parse(indiaUrl));
      if (response.statusCode == 200) {
        final Map indiaData = jsonDecode(response.body);
        return indiaData;
      } else {
        print("Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }
}
