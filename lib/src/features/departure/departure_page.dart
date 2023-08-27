import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vbb_transport/src/models/departure_item_model.dart';
import 'package:vbb_transport/src/services/api_service.dart';
import 'package:vbb_transport/src/widgets/departure_list_item_widget.dart';
import 'package:vbb_transport/src/widgets/error_message_widget.dart';
import 'package:vbb_transport/src/widgets/no_data_found_widget.dart';

class DeparturePage extends StatefulWidget {
  const DeparturePage({
    super.key,
    required this.queryText,
  });
  final String queryText;

  @override
  State<DeparturePage> createState() => _DeparturePageState();
}

class _DeparturePageState extends State<DeparturePage> {

  bool loading = true;
  bool hasError = false;
  List<DepartureItemModel> departures = [];
  final apiService = ApiService();

  @override
  void initState()  {
    super.initState();
    queryData();

  }

  Future<void> queryData() async {

    try {
      final departuresData = await apiService.getDepartures(widget.queryText);

      setState(() {
        departures = departuresData;
        loading = false;
      });

    } catch (error) {

      print("Error Here: ");
      print(error);
      setState(() {
        hasError = true;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Departures'),
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
          ) : departures.length == 0 ?
      SizedBox(
        width: double.infinity,
        child: NoDataFoundWidget(
          text: 'No departures found',
        ),
      ) : ListView.builder(
        itemCount: departures.length,
        itemBuilder: (context, index) {
          final item = departures[index];
          return DepartureListItemWidget(item: item);
        },
      ),


    );
  }
}



