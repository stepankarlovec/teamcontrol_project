import 'package:app/app/homepage/homepage_service.dart';
import 'package:app/app/profile/profile_widget.dart';
import 'package:app/config/utils.dart';
import 'package:app/providers/provider_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../models/event.dart';
import '../../pages/CalendarPage.dart';

// Default app bar used everywhere ( not extended )
AppBar defaultAppBar(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return AppBar(
    backgroundColor: const Color(0xffff585f),
    bottom: const PreferredSize(
      preferredSize: Size.fromHeight(10),
      child: SizedBox(height: 8),
    ),
    leading: Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Builder(
        builder: (BuildContext context)  {
          return GestureDetector(
            onTap: () {
              if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
                scaffoldKey.currentState?.openEndDrawer();
              } else {
                print("opening classic");
                Scaffold.of(context).openDrawer();
              }
            },
            child: SvgPicture.asset(
              'assets/icons/menu.svg',
              width: 20,
              height: 20,
              color: Colors.white,
            ),
          );
        }
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ProfileWidget()),
          );
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10, right: 20),
          width: 40,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: SvgPicture.asset(
              'assets/icons/user.svg',
              width: 20,
              height: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  );
}



AppBar AppBarBack(
    BuildContext context, scaffoldKey) {
  return AppBar(
    backgroundColor: const Color(0xffff585f),
    bottom: const PreferredSize(
      preferredSize: Size.fromHeight(10),
      child: SizedBox(height: 8),
    ),
    leading: BackButton(),
    actions: [
      GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileWidget()));
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10, right: 20),
            width: 40,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              //child: Text('${Provider.of<Profile>(context, listen: false).firstName[0]}${Provider.of<Profile>(context, listen: false).lastName[0]}'),
              //child: Text('${Provider.of<ProfileProvider>(context, listen: false).firstName?.substring(0,1)} ${Provider.of<ProfileProvider>(context, listen: false).lastName?.substring(0,1)}')
              child: SvgPicture.asset(
                'assets/icons/user.svg',
                width: 20,
                height: 20,
                color: Colors.black,
              ),
            ),
          ))
    ],
  );
}

// App bar on the homepage
AppBar mainAppBar(BuildContext context, scaffoldKey) {
  late Event snapshotData;

  return AppBar(
    backgroundColor: const Color(0xffff585f),
    leading: Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => {
          if (scaffoldKey.currentState!.isDrawerOpen)
            {scaffoldKey.currentState?.openEndDrawer()}
          else
            {print("opening"),scaffoldKey.currentState?.openDrawer()}
        },
        child: SvgPicture.asset(
          'assets/icons/menu.svg',
          width: 20,
          height: 20,
          color: Colors.white,
        ),
      ),
    ),
    actions: [
      GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileWidget()));
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10, right: 20),
            width: 40,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: SvgPicture.asset(
                'assets/icons/user.svg',
                width: 20,
                height: 20,
                color: Colors.black,
              ),
            ),
          ))
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(140),
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 18, right: 26),
          alignment: Alignment.centerLeft,
          child: FutureBuilder(
          future: getLatestEvent(context),
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              snapshotData = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Next event",
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(truncateText(snapshotData.name, 16),
                            style: TextStyle(fontSize: 40, color: Colors
                                .white)),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CalendarPage()));
                          },
                          child: SvgPicture.asset('assets/icons/calendar.svg',
                              width: 40, height: 40, color: Colors.white),
                        ),
                      ]),
                  Text(
                    '${getDayString(snapshotData.date)} ${snapshotData.date.day}.${snapshotData.date.month}.${snapshotData.date.year}',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              );
            }
          })
  ),
    ),
  );
}
