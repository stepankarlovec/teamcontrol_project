import 'dart:convert';
import 'package:app/app/notifications/displayNotifications_widget.dart';
import 'package:app/models/defaultRequest.dart';
import 'package:app/models/profile.dart';
import 'package:app/config/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/error.dart';
import '../../../providers/provider_user.dart';

Future<Object> createMessage(message, context) async {
  final response = await http.post(
    Uri.parse('${globals.SERVER_DOMAIN}/api/message'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
    body: jsonEncode(<String, String>{
      'message': message,
      'user_id': Provider.of<User>(context, listen: false).ID.toString(),
    }),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("New event successfully added."),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DisplayNotificationWidget()));
  } else {
    return ErrorRequest.fromJson(jsonDecode(response.body));
  }
}
