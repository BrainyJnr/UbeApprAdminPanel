import 'package:admin_panel/widgets/user_data_list.dart';
import 'package:flutter/material.dart';

import '../methods/common_method.dart';

class UsersPage extends StatefulWidget {
  static const String id = "\¤ebPageUsers";

  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
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
            "Manage Users",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          children: [
            cMethods.header(2, "USER ID"),
            cMethods.header(1, " NAME"),
            cMethods.header(1, " EMAIL"),
            cMethods.header(1, "PHONE"),
            cMethods.header(1, "ACTION"),
          ],
        ),

        //display data
            UserDataList()
      ])),
    ));
  }
}
