import 'dart:convert';
import 'package:app/app/admin/dashboard/adminDashboard_widget.dart';
import 'package:app/models/apology.dart';
import 'package:app/models/defaultRequest.dart';
import 'package:app/models/profile.dart';
import 'package:app/config/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/UserForeign.dart';
import '../../../models/error.dart';
import '../../../models/event.dart';
import '../../../providers/provider_user.dart';

Future<UserForeign> getPlayer(context, int userId) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/user/$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
  );

  if (response.statusCode == 201 || response.statusCode == 200) {

    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return UserForeign.fromJson(jsonResponse);

  } else {
    throw Exception("Something went wrong.");
  }
}

Future<List<Apology>> getPlayerApologies(context, int userId) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/apology/$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    if (jsonList.isNotEmpty) {
      List<Apology> events = jsonList.map((json) => Apology.fromJson(json)).toList();
      print(events.isNotEmpty ? events[0] : "No apologies found");
      return events;
    } else {
      print("No events found");
      return []; // Return an empty list if no events are found
    }
  } else {
    return []; // Return an empty list if no events are found
  }
}

Future<List<Event>> getPlayerEvents(context, int userId) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/event/user/$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    if (jsonList.isNotEmpty) {
      List<Event> events = jsonList.map((json) => Event.fromJson(json)).toList();
      print(events.isNotEmpty ? events[0] : "No events found");
      return events;
    } else {
      print("No events found");
      return []; // Return an empty list if no events are found
    }
  } else {
    return []; // Return an empty list if no events are found
  }
}

Future<Object> kickFromTeam(context, userId) async {
  final response = await http.post(
    Uri.parse('${globals.SERVER_DOMAIN}/api/teams/user/remove'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
    body: jsonEncode(<String, String>{
      'user_id': userId.toString(),
    }),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    var req = DefaultRequest.fromJson(jsonDecode(response.body));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(req.message),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AdminDashboardWidget()));
  } else {
    var req = ErrorRequest.fromJson(jsonDecode(response.body));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(req.message),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AdminDashboardWidget()));
  }
}

Future<Object> promoteToAdministrator(context, userId) async {
  final response = await http.post(
    Uri.parse('${globals.SERVER_DOMAIN}/api/user/changerole'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
    body: jsonEncode(<String, String>{
      'user_id': userId.toString(),
    }),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    var req = DefaultRequest.fromJson(jsonDecode(response.body));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(req.message),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    return req;
  } else {
    var req = ErrorRequest.fromJson(jsonDecode(response.body));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(req.message),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
    return req;
  }
}