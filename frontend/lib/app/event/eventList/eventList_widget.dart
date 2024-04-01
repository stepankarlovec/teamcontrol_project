import 'package:app/app/event/eventList/eventList_service.dart';
import 'package:flutter/material.dart';
import 'package:app/models/event.dart';

import '../../components/appBars.dart';
import '../../components/drawer.dart';
import '../displayPage/displayEvent_widget.dart';

class EventListWidget extends StatefulWidget {
  EventListWidget({super.key});

  @override
  State<EventListWidget> createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventListWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Event> eventData;

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
            Text("Events"),
            buildFutureEvents(context)
          ]),
        ),
      ),
    );
  }

  FutureBuilder<List<Event>> buildFutureEvents(BuildContext context) {
    return FutureBuilder(
        future: getAllEvents(context),
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
                                          event: Event(name: eventData[index].name, date: eventData[index].date, duration: eventData[index].duration, repeated: eventData[index].repeated, color: eventData[index].color, location: eventData[index].location, creator_id: eventData[index].creator_id)
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
