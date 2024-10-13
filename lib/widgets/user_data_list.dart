import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../methods/common_method.dart';

class UserDataList extends StatefulWidget {
  const UserDataList({super.key});

  @override
  State<UserDataList> createState() => _UserDataListState();
}

class _UserDataListState extends State<UserDataList> {

  final usersRecordFromDatabase =
  FirebaseDatabase.instance.ref().child("users");
  CommonMethods cMethods = CommonMethods();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: usersRecordFromDatabase.onValue,
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

                      cMethods.data(1, Text(itemList[index]["name"].toString())),

                      cMethods.data(1, Text(itemList[index]["email"].toString())),

                      cMethods.data(
                          1, Text(itemList[index]["phone"].toString())),
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
                                  .child("users")
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
                                    .child("users")
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
