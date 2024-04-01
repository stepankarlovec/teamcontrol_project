import 'dart:convert';
import 'package:app/models/profile.dart';
import 'package:app/config/globals.dart' as globals;
import 'package:app/pages/CalendarPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/error.dart';
import '../../../providers/provider_user.dart';
import '../../models/apology.dart';
import '../homepage/homepage.dart';

Future<Object> createApology(Apology apology, context) async {
  final response = await http.post(
    Uri.parse('${globals.SERVER_DOMAIN}/api/apology'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
    body: jsonEncode(<String, String>{
      'name': apology.name,
      'text': apology.text,
      'dateFrom': apology.dateFrom.toString(),
      'dateUntil': apology.dateUntil.toString(),
      'user_id': apology.userId.toString(),
    }),
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("New apology successfully added."),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Homepage()));
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
