import 'package:app/app/components/appBars.dart';
import 'package:app/app/components/drawer.dart';
import 'package:app/app/event/newEvent/new_event_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/event.dart';
import '../../providers/provider_user.dart';
import '../components/EventDataSource.dart';
import '../event/displayPage/displayEvent_widget.dart';
import 'calendar_domain.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Event>> _getDataSource() async {
    try {
      return await getEvents(context);
    } catch (error) {
      print("Error fetching events: $error");
      rethrow; // rethrow the error to be caught by FutureBuilder
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: defaultAppBar(context, _scaffoldKey),
        drawer: buildDrawer(context),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.80,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: [
                Provider.of<User>(context, listen: false).role>=1 ?
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const NewEventWidget()));
                    },
                    child: const Text("+ Add event"),
                  ),
                ) : Text(""),
                FutureBuilder(
                    future: _getDataSource(),
                    initialData: [],
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      print("SNAPSHOT DATA");
                      print(snapshot.data);
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data != null &&
                          snapshot.data.isNotEmpty) {
                        return SafeArea(
                          child: SizedBox(
                            height: 500,
                            child: SfCalendar(
                              dataSource: EventDataSource(snapshot.data),
                              onTap: (tap){
                                print(tap.appointments?.first);
                                if(tap.appointments?.first != null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          DisplayEventWidget(
                                              event: Event(name: tap.appointments?.first.name, date: tap.appointments?.first.date, duration: tap.appointments?.first.duration, repeated: tap.appointments?.first.repeated, color: tap.appointments?.first.color, location: tap.appointments?.first.location, creator_id: tap.appointments?.first.creator_id, id: tap.appointments?.first.id))));
                                }

                              },
                              view: CalendarView.week,
                              timeSlotViewSettings: const TimeSlotViewSettings(
                                timeIntervalHeight: 30,
                              ),
                              monthViewSettings: const MonthViewSettings(
                                  appointmentDisplayMode:
                                  MonthAppointmentDisplayMode.appointment),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('No events available.'),
                        );
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
