import 'package:app/app/admin/player/player_service.dart';
import 'package:app/models/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/apology.dart';
import '../../../providers/provider_user.dart';
import '../../components/appBars.dart';
import '../../components/drawer.dart';
import '../../event/displayPage/displayEvent_widget.dart';
import '../apologies/apologyDisplay_widget.dart';

class PlayerWidget extends StatefulWidget {
  int idOfPlayer;
  PlayerWidget({super.key, required this.idOfPlayer});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String switcher = "apology";
  late List<Apology> apologyData;
  late List<Event> eventData;


  void switchButton(button){
    setState(() {
      switcher = button;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: buildDrawer(context),
        appBar: AppBarBack(context, _scaffoldKey),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: FutureBuilder(
              future: getPlayer(context, this.widget.idOfPlayer),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(width: 80, height: 80, child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Provider.of<User>(context, listen: false).role>=1 ?
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              OutlinedButton(onPressed: (){ kickFromTeam(context, this.widget.idOfPlayer); }, child: Text("Kick from team"), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.red))),
                              OutlinedButton(onPressed: (){ promoteToAdministrator(context, this.widget.idOfPlayer); }, child: Text("Change role"), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.green))),
                            ],
                          ),
                        ):Text(""),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text("${snapshot.data.person.firstName} ${snapshot.data.person.lastName}", style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold
                              )),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16),
                              width: 160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Height: ${snapshot.data.person.height}", textAlign: TextAlign.left),
                                  Text("Weight: ${snapshot.data.person.weight}", textAlign: TextAlign.left),
                                  Text("Position: ${snapshot.data.person.position}", textAlign: TextAlign.left),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(onPressed: (){
                              switchButton("apology");
                              },
                              child: Text("Apologies"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(switcher=="apology"?Colors.purple:Colors.white),
                                foregroundColor: MaterialStateProperty.all<Color>(switcher=="apology"?Colors.white:Colors.purple),
                              ),
                            ),
                            OutlinedButton(onPressed: (){
                              switchButton("event");
                            },
                              child: Text("Events"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(switcher=="event"?Colors.purple:Colors.white),
                                foregroundColor: MaterialStateProperty.all<Color>(switcher=="event"?Colors.white:Colors.purple),
                              ),
                            ),
                          ],
                        ),
                        switchingFutures(snapshot)
                      ],
                    );
                  }
                  })
            ),
          ),
    );
  }

  Widget switchingFutures(snapshot){
    return switcher=="apology"?buildFutureApologies(context, snapshot):buildFutureEvents(context, snapshot);
  }

  FutureBuilder<List<Event>> buildFutureEvents(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return FutureBuilder(
        future: getPlayerEvents(context, snapshot.data.ID),
        builder: (context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            eventData = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...List.generate(eventData.length, (index) =>
                    Row(
                      children: [
                        Text(eventData[index].name),
                        Text("-"),
                        Text(eventData[index].date.day.toString() + "/" + eventData[index].date.month.toString() + "/" + eventData[index].date.year.toString()),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0),
                          child: TextButton(onPressed: () {
                            if(eventData[index] is Event) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                  DisplayEventWidget(
                                      event: Event(name: eventData[index].name, date: eventData[index].date, color: eventData[index].color, duration: eventData[index].duration, repeated: eventData[index].repeated, location: eventData[index].location, creator_id: eventData[index].creator_id)
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


  FutureBuilder<List<Apology>> buildFutureApologies(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return FutureBuilder(
                      future: getPlayerApologies(context, snapshot.data.ID),
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
                                      Text("${apologyData[index].dateFrom.day}/${apologyData[index].dateFrom.month}/${apologyData[index].dateFrom.year}}", style: TextStyle(
                                          fontSize: 14
                                      )),
                                      Text("-"),
                                      Text("${apologyData[index].dateUntil.day}/${apologyData[index].dateUntil.month}/${apologyData[index].dateUntil.year}", style: TextStyle(
                                          fontSize: 14
                                      )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0),
                                        child: OutlinedButton(onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplayApologyWidget(
                                                      apology: Apology(id: apologyData[index].id, name: apologyData[index].name, dateFrom: apologyData[index].dateFrom, dateUntil: apologyData[index].dateUntil, userId: apologyData[index].userId, text: apologyData[index].text)
                                                  )
                                          ));
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
