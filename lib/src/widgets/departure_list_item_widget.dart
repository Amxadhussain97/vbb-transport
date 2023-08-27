import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vbb_transport/src/models/departure_item_model.dart';

class DepartureListItemWidget extends StatelessWidget {
  final DepartureItemModel item;


  const DepartureListItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final remarks = item.remarks ?? [];
    final line = item.line ?? {};
    final destination = item.destination ?? {};

    // FILTERING TIME AND DATE FROM WHEN
    final date = item.when != null ? DateFormat('dd-MM-yyyy').format(item.when!) : '';
    final time = item.when != null ? DateFormat('HH:mm').format(item.when!) : '';


    return Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: ListTile(

            title: Text(
              'Direction: ${item.direction}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                Text(
                  'Platform: ${item.platform}',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Line: ${line['name']}',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black87
                  ),
                ),
                SizedBox(height: 4.0),
                // five item.when as readable date
                Text(
                  'Delay: ${item.delay} minutes',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black87
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'When: ${date}, ${time}',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black87
                  ),
                ),
                SizedBox(height: 4.0),

                Text(
                  'Destination: ${destination['name']}',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black87
                  ),
                ),
                //   give remarks
                SizedBox(height: 4.0),
                Text(
                  'Remarks: ',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black87
                  ),
                ),
                ...remarks.map((e) => Text(
                  e['text'],
                  style: TextStyle(
                      fontSize: 14.0,
                      // give color secondary
                      // give secondary color
                      color: Colors.black54


                    // margin: EdgeInsets.only(left: 20.0),

                  ),
                )),

              ],
            ),

          ),
        )
    );
  }
}