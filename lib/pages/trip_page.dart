import 'package:admin_panel/widgets/trip_data_list.dart';
import 'package:flutter/material.dart';

import '../methods/common_method.dart';

class TripPage extends StatefulWidget {

  static const String id = "\¤ebPageTrips";

  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  CommonMethods cMethods = CommonMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          // 4% of screen width for responsive padding
          child: SingleChildScrollView(
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Manage Trips",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    cMethods.header(2, "TRIP ID"),
                    cMethods.header(1, " USER NAME"),
                    cMethods.header(1, " DRIVER NAME"),
                    cMethods.header(1, "CAR DETAILS"),
                    cMethods.header(1, "TIMING"),
                    cMethods.header(1, "FARE"),
                    cMethods.header(1, "VIEW DETAILS"),
                  ],
                ),           TripsDataList(),

              ])),
        ));
  }
}
