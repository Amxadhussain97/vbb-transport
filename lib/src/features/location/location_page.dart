import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbb_transport/src/models/stop_item_model.dart';
import 'package:vbb_transport/src/services/api_service.dart';
import 'package:vbb_transport/src/services/stop_service.dart';
import 'package:vbb_transport/src/widgets/error_message_widget.dart';
import 'package:vbb_transport/src/widgets/no_data_found_widget.dart';
import 'package:vbb_transport/src/widgets/stop_list_item_widget.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({
    super.key,
    required this.queryText,
  });
  final String queryText;

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  bool loading = true;
  bool hasError = false;
  List<StopsItemModel> stops = [];
  final apiservice = ApiService();
  final stopService = StopService();

  @override
  void initState()  {
    super.initState();
    queryData();

  }

  queryData() async {

    try {

      hasError = false;

      final stopsData = await apiservice.getStops(widget.queryText);
      stops.clear();
      stops.addAll(stopsData);

      // CHECKING WHICH STOPS ARE FAVORITE
      List<StopsItemModel> filteredStops = await stopService
          .filterFavoritesFromSharedPreferences(stops);


      setState(() {
        stops = filteredStops;
        loading = false;
      });
    }
    catch (error) {
      setState(() {
        hasError = true;
        loading = false;
      });
    }


  }



  void onToggleFavorite(StopsItemModel stop) async {

    // GET FAVORITE STOPS FROM SHARED PREFERENCES
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favStopsJsonString = prefs.getString('favoriteStops');
    List<StopsItemModel> favStops = [];

    if (favStopsJsonString != null) {
      favStops = stopService.convertFavStopJsonStringToListObj(favStopsJsonString);
    }


    if (!stop.isFavorite && !stopService.isStopInFavorites(favStops, stop.id)) {

      // STOP IS NOT IN FAVORITES, ADD IT TO SHARED PREFERENCES
      favStops.add(stop);
      String favStopsJsonString = stopService.convertFavStopListObjToJsonString(favStops);
      prefs.setString('favoriteStops', favStopsJsonString);

    } else if (stop.isFavorite && stopService.isStopInFavorites(favStops, stop.id)) {

      // STOP IS IN FAVORITES, REMOVE IT FROM SHARED PREFERENCES
      favStops.removeWhere((favStop) => favStop.id == stop.id);
      String favStopsJsonString = stopService.convertFavStopListObjToJsonString(favStops);
      prefs.setString('favoriteStops', favStopsJsonString);

    }

    // UPDATE THE STATE BY TOGGLING THE FAVORITE
    setState(() {
      stop.isFavorite = !stop.isFavorite;
    });
  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Stops'),
      ),
      body: loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : hasError
          ? SizedBox(
        width: double.infinity,
        child: ErrorMessageWidget(
          onPressed:queryData,
        ),
        ) : stops.length == 0 ?
      SizedBox(
        width: double.infinity,
        child: NoDataFoundWidget(
          text: "No stops found"
        ),
      ) : ListView.separated(
        itemCount: stops.length,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (BuildContext context, int index) {
          final item = stops[index];

          return StopsListItemWidget(
            item: item,
            onToggleFavorite: onToggleFavorite,
          );
        },
      ),


    );


  }
}


