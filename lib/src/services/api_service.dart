import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vbb_transport/src/models/departure_item_model.dart';

import '../models/stop_item_model.dart';

class ApiService {


  final String baseUrl = "https://v6.vbb.transport.rest";
  Future<List<StopsItemModel>> getStops(String query) async {

    final String url = "$baseUrl/locations?query=$query&results=10";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final stopDataList = <StopsItemModel>[];
      for (var item in responseBody) {
        final location = StopsItemModel.fromJson(item);
        if (location.type == 'stop') stopDataList.add(location);
      }
      return stopDataList;
    }

    return [];
  }



  Future<List<DepartureItemModel>> getDepartures(String id) async {
    final String url = "$baseUrl/stops/$id/departures";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final departures = responseBody['departures']; // Retrieve the 'departures' object value
      final departureDataList = <DepartureItemModel>[];
      for (var item in departures) {
        final departure = DepartureItemModel.fromJson( item);
        print(departure);
        // check departure is not null
        departureDataList.add(departure);
      }
      return departureDataList;
    }

    return [];
  }


}
