import 'package:admin_panel/dashboard/dashboard.dart';
import 'package:admin_panel/pages/drivers_page.dart';
import 'package:admin_panel/pages/trip_page.dart';
import 'package:admin_panel/pages/users_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

//common users
//drivers
//admins

class SideNaviagtionDrawer extends StatefulWidget {
  const SideNaviagtionDrawer({super.key});

  @override
  State<SideNaviagtionDrawer> createState() => _SideNaviagtionDrawerState();
}

class _SideNaviagtionDrawerState extends State<SideNaviagtionDrawer> {

  Widget chooseScreen = Dashboard();

  sendAdminTo(selectedPage){
    switch(selectedPage.route){
      case DriversPage.id:
        setState(() {
          chooseScreen = DriversPage();
        });
        break;

      case UsersPage.id:
        setState(() {
          chooseScreen = UsersPage();
        });
        break;

      case TripPage.id:
        setState(() {
          chooseScreen = TripPage();
        });
        break;

    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return AdminScaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 1),
      appBar: AppBar(backgroundColor: Colors.pink,
          title: Text(
        "Admin  Web Panel",
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white
        ),
      )),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: "Drivers",
            route: DriversPage.id,
            icon: CupertinoIcons.car_detailed,
          ),
          AdminMenuItem(
            title: "User",
            route: UsersPage.id,
            icon: CupertinoIcons.person_2_fill,
          ),
          AdminMenuItem(
            title: "Trips",
            route: TripPage.id,
            icon: CupertinoIcons.location_fill,
          )
        ],
        selectedRoute: DriversPage.id,
        onSelected: (selectedPage) {
          sendAdminTo(selectedPage);
        },
        header: Container(
          height: screenHeight * 0.06, // 6% of the screen height
          width: double.infinity,
          color: Colors.pink.shade500,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.accessibility,color: Colors.white,),
              SizedBox(width: 10,),
              Icon(Icons.settings,color: Colors.white,)

            ],
          ),
        ),
        footer: Container(
          height: screenHeight * 0.06, // 6% of the screen height
          width: double.infinity,
          color: Colors.pink.shade500,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.admin_panel_settings_outlined,color: Colors.white,),
              SizedBox(width: 10,),
              Icon(Icons.computer,color: Colors.white,)

            ],
          ),
        ),
      ),
      body: chooseScreen,
    );
  }
}
