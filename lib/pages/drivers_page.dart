import 'package:admin_panel/methods/common_method.dart';
import 'package:admin_panel/widgets/drivers_data_list.dart';
import 'package:flutter/material.dart';

class DriversPage extends StatefulWidget {
  static const String id = "\¤ebPageDrivers";

  const DriversPage({super.key});

  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  CommonMethods cMethods = CommonMethods();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
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
                    "Manage Drivers",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    cMethods.header(2, "DRIVER ID"),
                    cMethods.header(1, "PICTURE"),
                    cMethods.header(1, "NAME"),
                    cMethods.header(1, "CAR DETAILS"),
                    cMethods.header(1, "PHONE"),
                    cMethods.header(1, "TOTAL EARNINGS"),
                    cMethods.header(1, "ACTION"),

                    //display data
                  ],
                ),

                DriversDataList()

              ]),
        )));
  }
}
