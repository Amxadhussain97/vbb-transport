import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbb_transport/src/models/stop_item_model.dart';
import 'package:vbb_transport/src/services/stop_service.dart';
import 'package:vbb_transport/src/widgets/stop_list_item_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  List<StopsItemModel> stops = [
  ];
  bool loading = false;
  bool hasError = false;
  final stopService = StopService();

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favStopsJsonString = prefs.getString('favoriteStops');


    if (favStopsJsonString != null) {
      List<StopsItemModel> favStops = stopService.convertFavStopJsonStringToListObj(favStopsJsonString);
      setState(() {
        stops = favStops;
      });
    }


  //   loop through stops and print name
    stops.forEach((element) {
      print(element.products);
    });

  }

  // bool isStopInFavorites(List<dynamic> favoriteStops, String stopId) {
  //   return favoriteStops.any((jsonObject) => jsonObject['id'] == stopId);
  // }
  //
  //
  void onToggleFavorite(StopsItemModel stop) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favStopsJsonString = prefs.getString('favoriteStops');
    List<StopsItemModel> favStops = [];

    if (favStopsJsonString != null) {
      favStops = stopService.convertFavStopJsonStringToListObj(favStopsJsonString);
    }

  //   remove the stop from the list
    favStops.removeWhere((element) => element.id == stop.id);

  //   convert the list to json string
     favStopsJsonString = stopService.convertFavStopListObjToJsonString(favStops);
    prefs.setString('favoriteStops', favStopsJsonString);

    setState(() {
      stops = favStops;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stops"),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (hasError) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red.shade300,
                      size: 60,
                    ),
                    const SizedBox(height: 12),
                    const Text("Something went wrong when fetching data"),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Try again"),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              itemCount: stops.length,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (BuildContext context, int index) {
                final item = stops[index];



                return StopsListItemWidget(
                  item: item,
                  onToggleFavorite: onToggleFavorite,
                  isDeletable: true,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
