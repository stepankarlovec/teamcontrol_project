import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/defaultRequest.dart';
import '../../../../models/error.dart';
import '../../../../models/group.dart';
import 'package:app/config/globals.dart' as globals;
import 'package:http/http.dart' as http;

import '../../../../providers/provider_user.dart';


Future<Object> createGroup(Group group, context) async {
  final response = await http.post(
    Uri.parse('${globals.SERVER_DOMAIN}/api/group'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
    body: jsonEncode(<String, String>{
      'name': group.name,
      'users': group.users,
      'team_id': Provider.of<User>(context, listen: false).teamId.toString(),
      'permanent': "1",
    }),
  );

  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("New group successfully created."),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    return DefaultRequest.fromJson(jsonDecode(response.body));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Something went wrong."),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    return ErrorRequest.fromJson(jsonDecode(response.body));
  }
}