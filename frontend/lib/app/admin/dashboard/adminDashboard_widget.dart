import 'package:app/app/admin/apologies/apologyList_widget.dart';
import 'package:app/app/admin/createNotification/createNotification_widget.dart';
import 'package:app/app/admin/inviteUser/inviteUser_widget.dart';
import 'package:app/app/admin/player/player_widget.dart';
import 'package:app/app/apologies/apology_service.dart';
import 'package:app/app/event/eventList/eventList_widget.dart';
import 'package:app/models/UserForeign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../models/apology.dart';
import '../../../providers/provider_user.dart';
import '../../components/appBars.dart';
import '../../components/datePicker.dart';
import '../../components/drawer.dart';
import '../../components/timePicker.dart';
import 'adminDashboard_service.dart';

class AdminDashboardWidget extends StatefulWidget {
  const AdminDashboardWidget({super.key});

  @override
  State<AdminDashboardWidget> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboardWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<UserForeign>> usersFuture;
  late List<UserForeign> snapshotData;

  void initState() {
    super.initState();
    usersFuture = getTeammates(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: buildDrawer(context),
        appBar: defaultAppBar(context, _scaffoldKey),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  OutlinedButton(onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ApologyListWidget()));
                  }, child: Text('Apology')),
                  OutlinedButton(onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EventListWidget()));
                  }, child: Text('Events'))
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const InviteUserWidget()));
                }, child: Text('Add new user')),
              )
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: FutureBuilder(
                future: usersFuture,
                builder: (context, AsyncSnapshot<List<UserForeign>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    snapshotData = snapshot.data!;

                    return Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment
                            .middle,
                        children: [
                          TableRow(children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment
                                  .middle,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Text("Users", style: TextStyle(fontSize: 26),),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment
                                  .middle,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                              ),
                            ),
                          ]),
                          ...List.generate(snapshotData.length, (index) =>
                                TableRow(children: [
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text("${snapshotData[index].person.firstName} ${snapshotData[index].person.lastName}"),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: OutlinedButton(onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlayerWidget(
                                                        idOfPlayer: snapshotData[index].ID)));
                                      }, child: Text("Profile")),
                                    ),
                                  ),
                                ]
                                )
                          )
                        ]
                    );
                  }
                }
            )
            )
            )
          ],
        )));
  }
}
