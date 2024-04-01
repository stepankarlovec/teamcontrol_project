import 'dart:convert';

import 'package:app/config/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/defaultRequest.dart';
import 'package:provider/provider.dart';

import '../../providers/provider_user.dart';
import '../noTeam/createTeam/create_team_service.dart';

/*
Future<DefaultRequest> getLatestEvent(String type, context) async {
  if(type!="match"||type!="training"){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Wrong event type!"),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
    return const DefaultRequest(message: "sometiiin went wrong");
  }
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/event/{$type}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider
          .of<User>(context, listen: false)
          .bearerToken}',
    },
  );

  print(response.body);

  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successfully created a team"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    
    return DefaultRequest(message: "success");
  } else {
    return DefaultRequest(message: "something went wrong.");
  }
}

 */