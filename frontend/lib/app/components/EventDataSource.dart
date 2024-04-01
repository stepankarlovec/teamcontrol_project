import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/event.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<dynamic> source) {
      appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    DateTime dt = appointments![index].date;
    return dt;
  }

  @override
  DateTime getEndTime(int index) {
    DateTime dt = appointments![index].date;

    DateTime hourLater = dt.add(Duration(minutes: appointments![index].duration));
    return hourLater;
  }

  @override
  String getSubject(int index) {
    return appointments![index].name;
  }

  Event getEventSource(int index){
    return appointments![index];
  }
/*
  @override
  String? getRecurrenceRule(int index){
    return appointments![index].repeated==1 ?
    'RULE:FREQ=WEEKLY;INTERVAL=1;BYDAY=${DateFormat('EE').format(appointments![index].date).toUpperCase()}'
    : null;
  }
*/
  @override
  Color getColor(int index) {
    return Color(int.parse(appointments![index].color.split('(')[1].split(')')[0]));
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}