import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbb_transport/src/models/stop_item_model.dart';

class StopService {



  bool isStopInFavorites(List<StopsItemModel> favoriteStops, dynamic stopId) {
    return favoriteStops.any((favStop) => favStop.id == stopId);
  }

  Future<List<StopsItemModel>> filterFavoritesFromSharedPreferences(List<StopsItemModel> stops) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favStopsJsonString = prefs.getString('favoriteStops');

    if (favStopsJsonString != null) {


      // CONVERTING FAVORITE STOPS JSON STRING TO LIST MODEL OBJECT
      List<dynamic> favStopsJsonList = jsonDecode(favStopsJsonString);

      List<StopsItemModel> favStops = favStopsJsonList.map((favStop) {

        if (favStop.containsKey('products') && favStop['products'] is String) {

          Map<String, dynamic> productsMap = jsonDecode(favStop['products']);

          Map<String, dynamic> favStopJson = Map<String, dynamic>.from(favStop);
          favStopJson.remove('products');
          favStopJson['products'] = productsMap;

          return StopsItemModel.fromJson(favStopJson);
        } else {
          return StopsItemModel.fromJson(favStop);
        }
      }).toList();

      List<StopsItemModel> updatedStops = [];
      stops.forEach((stop) {
        if (isStopInFavorites(favStops, stop.id)) {
          stop.isFavorite = true;
        }
        updatedStops.add(stop);
      });

      return updatedStops;
    }

    return stops;

  }

  List<StopsItemModel> convertFavStopJsonStringToListObj(String favStopsJsonString) {

    // DECODING THE JSON STRING TO A JSON LIST
    List<dynamic> favStopsJsonList = jsonDecode(favStopsJsonString);

    return favStopsJsonList.map((stop) {

      // CONVERTING JSON LIST TO LIST MODEL OBJECT
      if (stop.containsKey('products') && stop['products'] is String) {

        Map<String, dynamic> productsMap = jsonDecode(stop['products']);
        Map<String, dynamic> stopJson = Map<String, dynamic>.from(stop);
        stopJson.remove('products');
        stopJson['products'] = productsMap;

        return StopsItemModel.fromJson(stopJson);
      } else {
        return StopsItemModel.fromJson(stop);
      }
    }).toList();
  }

  String convertFavStopListObjToJsonString(List<StopsItemModel> favStops) {

    // CONVERTING LIST MODEL OBJECT TO JSON LIST
    List<Map<String, dynamic>> favStopsJsonList = favStops.map((favStop) {


      String productsJsonString = jsonEncode(favStop.products);


      Map<String, dynamic> favStopJson = {
        ...favStop.toJson(),
        'products': productsJsonString,
      };

      return favStopJson;
    }).toList();

    return jsonEncode(favStopsJsonList); // CONVERTING JSON LIST TO JSON STRING
  }
}