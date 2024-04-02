import 'package:app/app/admin/apologies/apologyDisplay_widget.dart';
import 'package:app/app/admin/apologies/apologyList_service.dart';
import 'package:app/config/utils.dart';
import 'package:app/models/apology.dart';
import 'package:flutter/material.dart';

import '../../components/appBars.dart';
import '../../components/drawer.dart';

class ApologyListWidget extends StatefulWidget {
  ApologyListWidget({super.key});

  @override
  State<ApologyListWidget> createState() => _ApologyListWidgetState();
}

class _ApologyListWidgetState extends State<ApologyListWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Apology> apologyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
      appBar: defaultAppBar(context, _scaffoldKey),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(children: [
            Text("Apologies"),
            buildFutureEvents(context)
          ]),
        ),
      ),
    );
  }

  FutureBuilder<List<Apology>> buildFutureEvents(BuildContext context) {
    return FutureBuilder(
        future: getAllApologies(context),
        builder: (context, AsyncSnapshot<List<Apology>> snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            apologyData = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...List.generate(apologyData.length, (index) =>
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(truncateText(apologyData[index].text, 18)),
                            Text("-"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("${apologyData[index].dateFrom.day}/${apologyData[index].dateFrom.month}/${apologyData[index].dateFrom.year} ${apologyData[index].dateFrom.hour.toString().padLeft(2,'0')}:${apologyData[index].dateFrom.minute.toString().padLeft(2,'0')}", style: TextStyle(
                                fontSize: 14
                            )),
                            Text("${apologyData[index].dateUntil.day}/${apologyData[index].dateUntil.month}/${apologyData[index].dateUntil.year} ${apologyData[index].dateUntil.hour.toString().padLeft(2,'0')}:${apologyData[index].dateUntil.minute.toString().padLeft(2,'0')}", style: TextStyle(
                                fontSize: 14
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0),
                          child: TextButton(onPressed: () {
                            if(apologyData[index] is Apology) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DisplayApologyWidget(
                                          apology: Apology(id: apologyData[index].id, name: apologyData[index].name, dateFrom: apologyData[index].dateFrom, dateUntil: apologyData[index].dateUntil, userId: apologyData[index].userId, text: apologyData[index].text)
                                      )
                              )
                              );
                            }else{
                              return null;
                            }
                          },
                            child: Text("Inspect"),
                          ),
                        ),
                      ],
                    )
                )
              ],
            );
          }
        }
    );
  }

}
