import 'package:app/app/admin/dashboard/adminDashboard_widget.dart';
import 'package:app/app/apologies/apology_widget.dart';
import 'package:app/app/calendar/calendar_widget.dart';
import 'package:app/app/homepage/homepage.dart';
import 'package:app/app/notifications/displayNotifications_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/provider_user.dart';

Drawer buildDrawer(BuildContext context) {


  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xffff585f),
          ),
          child: Image.asset('assets/images/logo_colored.png', width: 160)),
        ListTile(
          title: const Text('Home'),
          //selected: _selectedIndex == 0,
          onTap: () {
            // Update the state of the app
            //_onItemTapped(0);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Homepage()));
//              Navigator.pop(context);
            // Then close the drawer
            //Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Calendar'),
          //selected: _selectedIndex == 1,
          onTap: () {
            // Update the state of the app
            //_onItemTapped(1);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CalendarWidget()));
            // Then close the drawer
            //Navigator.pop(context);
          },
        ),
        /*
        ListTile(
          title: const Text('Matches'),
          //selected: _selectedIndex == 2,
          onTap: () {
            // Update the state of the app
            //_onItemTapped(2);
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
         */
        ListTile(
          title: const Text('Apologies'),
          //selected: _selectedIndex == 2,
          onTap: () {
            // Update the state of the app
            //_onItemTapped(2);
            // Then close the drawer
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ApologyWidget()));
          },
        ),
        ListTile(
          title: const Text('Messages'),
          //selected: _selectedIndex == 2,
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DisplayNotificationWidget()));
            // Update the state of the app
            //_onItemTapped(2);
            // Then close the drawer
            //Navigator.pop(context);
          },
        ),
        /*
        Provider.of<User>(context, listen: false).role>=1 ?
        ListTile(
          title: const Text('Groups'),
          //selected: _selectedIndex == 2,
          onTap: () {
            // Update the state of the app
            //_onItemTapped(2);
            // Then close the drawer
            Navigator.pop(context);
          },
        ) : Text(""),

         */
        Provider.of<User>(context, listen: false).role>=1 ?
        ListTile(
          title: const Text('Administrace'),
          //selected: _selectedIndex == 2,
          onTap: () {
            // Update the state of the app
            //_onItemTapped(2);
            // Then close the drawer
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AdminDashboardWidget()));
          },
        ) : Text(''),
      ],
    ),
  );
}
