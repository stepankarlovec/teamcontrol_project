import 'package:app/app/calendar/calendar_widget.dart';
import 'package:app/app/homepage/homepage_service.dart';
import 'package:app/app/homepage/latest_event_service.dart';
import 'package:app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/blockitem.dart';
import '../../models/event.dart';
import '../apologies/apology_widget.dart';
import '../components/appBars.dart';
import '../components/drawer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
      appBar: mainAppBar(context, _scaffoldKey),
      body: Container(
        child: Column(children: [
          buildNotifications(),
          const SizedBox(height: 20,),
          this.buildListView(),
        ]),
      ),
    );
  }
  final List<BlockItem> listOfItems = [
    //BlockItem(name: "Trénink", icon: 'football.svg', color: 0xff1e55b3, page: Homepage()),
    BlockItem(name: "Absence", icon: 'danger.svg', color: 0xff1e55b3, page: ApologyWidget()),
    BlockItem(name: "Kalendář", icon: 'calendar.svg', color: 0xff1e55b3, page: CalendarWidget()),
  ];

  SizedBox buildListView() {
    return SizedBox(
          height: 120,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: listOfItems.length,
                separatorBuilder: (context,index) => const SizedBox(width:25),
                padding: const EdgeInsets.only(
                  left: 20,
                  right:20,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => listOfItems[index].page));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(listOfItems[index].color)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/${listOfItems[index].icon}', width: 45, height:45, color: Colors.white),
                          const SizedBox(height: 15,),
                          Text(listOfItems[index].name, style: TextStyle(
                            color: Colors.white,
                            fontWeight:  FontWeight.bold,
                            fontSize: 14,
                          ),)
                        ],
                      ),
                    ),
                  );
                }));
  }

  FutureBuilder buildNotifications() {
    return FutureBuilder<List>(
      future: getLatestMessages(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var snapshotData = snapshot.data!;

          if(snapshotData.length==0){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("No new notifications."),
            );
          }

          return Container(
            height: 170,
            decoration: const BoxDecoration(
              color: Color(0xffd2f898),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text("Notifications",
                      style: TextStyle(
                        fontSize: 24,
                      )),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshotData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(children: [
                                Text(snapshotData[index].user_name ?? "", // Ensure user_name is not null
                                    style: TextStyle(fontSize: 16)),
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8)),
                                  margin: const EdgeInsets.only(left: 10),
                                )
                              ]),
                              const SizedBox(height: 5),
                              Text(snapshotData[index].message ?? "") // Ensure message is not null
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  }
