import 'dart:convert';
import 'package:app/models/profile.dart';
import 'package:app/config/globals.dart' as globals;
import 'package:app/pages/CalendarPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/error.dart';
import '../../../models/event.dart';
import '../../../providers/provider_user.dart';

Future<Object> createEvent(Event event, context) async {
  print(event.date.toString());
  final response = await http.post(
    Uri.parse('${globals.SERVER_DOMAIN}/api/event'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
    body: jsonEncode(<String, String>{
      'name': event.name,
      'date': event.date.toString(),
      'location': event.location,
      'duration': event.duration.toString(),
      'repeated': event.repeated.toString(),
      'creator_id': event.creator_id.toString(),
      'individualParticipants': event.individualParticipants ?? "",
      'groups': event.groups ?? "",
      'color': event.color ?? ""
    }),
  );

  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("New event successfully added."),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CalendarPage()));
    //return DefaultRequest.fromJson(jsonDecode(response.body));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("ERROR - Something went wrong."),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
    return ErrorRequest.fromJson(jsonDecode(response.body));
  }
}



Future<Profile> getProfile(context) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/person/${Provider.of<User>(context, listen: false).ID}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    print(response.body);
    return Profile.fromJson(jsonDecode(response.body), 0);
  } else {
    throw Exception("Something went wrong.");
  }
}
