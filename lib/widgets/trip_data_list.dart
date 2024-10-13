import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../methods/common_method.dart';
import 'package:url_launcher/url_launcher.dart';

class TripsDataList extends StatefulWidget {
  const TripsDataList({super.key});

  @override
  State<TripsDataList> createState() => _TripsDataListState();
}

class _TripsDataListState extends State<TripsDataList> {
  final Completedtripsrecordfromdatabase =
      FirebaseDatabase.instance.ref().child("tripRequests");
  CommonMethods cMethods = CommonMethods();

  launchGoogleMapFromSourceToDestination(
      pickUpLat, pickUpLng, dropOffLat, dropOffLng) async {
    String directionAPIUrl = "https:www.google.com/maps/dir/?api=1&origin=$pickUpLat,$pickUpLng&destination=$dropOffLat,$dropOffLng&dir_action=navigate";

    if(await canLaunchUrl(Uri.parse(directionAPIUrl))) {
      await launchUrl(Uri.parse(directionAPIUrl));
    } else {

      throw "Could not launch google map";

    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Completedtripsrecordfromdatabase.onValue,
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
                if (itemList[index]["status"] != null &&
                    itemList[index]["status"] == "ended") {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cMethods.data(
                            2, Text(itemList[index]["tripID"].toString())),
                        cMethods.data(
                            1, Text(itemList[index]["userName"].toString())),
                        cMethods.data(
                            1, Text(itemList[index]["driverName"].toString())),
                        cMethods.data(
                            1, Text(itemList[index]["carDetails"].toString())),
                        cMethods.data(
                            1,
                            Text(
                                itemList[index]["publishDateTime"].toString())),
                        cMethods.data(
                            1,
                            Text("\$ " +
                                itemList[index]["fareAmount"].toString())),
                        cMethods.data(
                            1,
                            ElevatedButton(
                                onPressed: () {
                                  String pickUpLat = itemList[index]
                                      ["pickUpLatLng"]["latitude"];
                                  String pickUpLng = itemList[index]
                                      ["pickUpLatLng"]["longitude"];

                                  String dropOffLat = itemList[index]
                                      ["dropOffLatLng"]["latitude"];
                                  String dropOffLng = itemList[index]
                                      ["dropOffLatLng"]["longitude"];

                                  launchGoogleMapFromSourceToDestination(
                                      pickUpLat,
                                      pickUpLng,
                                      dropOffLat,
                                      dropOffLng);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink.shade500,
                                ),
                                child: Text(
                                  "View More",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )))
                      ]);
                } else {
                  return Container();
                }
              });
        });
  }
}
