// get last 5 messages
import 'dart:convert';

import 'package:app/config/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/defaultRequest.dart';
import 'package:provider/provider.dart';

import '../../models/event.dart';
import '../../models/message.dart';
import '../../providers/provider_user.dart';

// vezme všechny
Future<List<Message>> getMessages(context) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/latest/messages'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider
          .of<User>(context, listen: false)
          .bearerToken}',
    },
  );

  if (response.statusCode == 201) {
    List<dynamic> jsonList = json.decode(response.body);
    if (jsonList.isNotEmpty) {
      List<Message> events = jsonList.map((json) => Message.fromJson(json)).toList();
      return events;
    } else {
      print("No events found");
      return []; // Return an empty list if no events are found
    }
  } else {
    throw Error();
  }
}

// vezme poslednich 5
Future<List<Message>> getLatestMessages(context) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/latest/messages'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
  );

  if (response.statusCode == 201) {
    List<dynamic> jsonList = json.decode(response.body);
    if (jsonList.isNotEmpty) {
      List<Message> messages = jsonList.map((json) => Message.fromJson(json)).toList();

      // Return only the first 5 messages
      return messages.take(5).toList();
    } else {
      print("No messages found");
      return []; // Return an empty list if no messages are found
    }
  } else {
    throw Error();
  }
}

// get latest event

Future<List<Event>> getLatestEvents(context) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/latest/events'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider
          .of<User>(context, listen: false)
          .bearerToken}',
    },
  );
  print(response.body);

  if (response.statusCode == 201) {
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
    throw Error();
  }
}

Future<Event> getLatestEvent(context) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/latest/events'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider
          .of<User>(context, listen: false)
          .bearerToken}',
    },
  );
  print(response.body);

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    if (jsonList.isNotEmpty) {
      List<Event> events = jsonList.map((json) => Event.fromJson(json)).toList();
      print(events.isNotEmpty ? events[0] : "No events found");
      return events[0];
    } else {
      print("No events found");
      return Event(name: "Nothing", color: "0xffffff", location: "Pardubice, Na Hůrce", repeated: 0, creator_id: 0,duration: 60, date: DateTime.now()); // Return an empty list if no events are found
    }
  } else {
    throw Exception("Server error - 500");
  }
}

