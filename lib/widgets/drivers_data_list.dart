import 'package:admin_panel/methods/common_method.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DriversDataList extends StatefulWidget {
  const DriversDataList({super.key});

  @override
  State<DriversDataList> createState() => _DriversDataListState();
}

class _DriversDataListState extends State<DriversDataList> {
  final driversRecordFromDatabase =
      FirebaseDatabase.instance.ref().child("drivers");
  CommonMethods cMethods = CommonMethods();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: driversRecordFromDatabase.onValue,
        builder: (BuildContext context, snapshotData) {
          if (snapshotData.hasError) {
            return const Center(
              child: Text(
                "Error Occurred, Try Later",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.pink),
              ),
            );
          }
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          Map dataMap = snapshotData.data!.snapshot.value as Map;
          List itemList = [];
          dataMap.forEach((key, value) {
            itemList.add({"key": key, ...value});
          });

          return ListView.builder(
              shrinkWrap: true,
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cMethods.data(2, Text(itemList[index]["id"].toString())),
                      cMethods.data(
                          1,
                          Image.network(
                            itemList[index]["photo"].toString(),
                            width: MediaQuery.of(context).size.width *
                                0.1, // 10% of the screen width
                            height: MediaQuery.of(context).size.height *
                                0.1, //                     ))
                          )),

                      cMethods.data(
                          1, Text(itemList[index]["name"].toString())),

                      cMethods.data(
                          1,
                          Text(itemList[index]["car_details"]["carModel"]
                                  .toString() +
                              " - " +
                              itemList[index]["car_details"]["carNumber"]
                                  .toString())),

                      cMethods.data(
                          1, Text(itemList[index]["phone"].toString())),

                      cMethods.data(
                          1,
                          itemList[index]["earnings"] != null
                              ? Text("\$ " +
                                  itemList[index]["earnings"].toString())
                              : const Text("\$ 0")),

                      //   cMethods.data(2, Text(itemList[index]["TOTAL EARNINGS"].toString())),

                      cMethods.data(
                          1,
                          itemList[index]["BlockStatus"] == "no"
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(),
                                      backgroundColor: Colors.pink),
                                  onPressed: () async {
                                    await FirebaseDatabase.instance
                                        .ref()
                                        .child("drivers")
                                        .child(itemList[index]["id"])
                                        .update({"BlockStatus": "yes"});
                                  },
                                  child: Text(
                                    "Block",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(),
                                      backgroundColor: Colors.pink),
                                  onPressed: () async {
                                    await FirebaseDatabase.instance
                                        .ref()
                                        .child("drivers")
                                        .child(itemList[index]["id"])
                                        .update({"BlockStatus": "no"});
                                  },
                                  child: const Text(
                                    "Approve",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )))
                    ]);
              });
        });
  }
}
