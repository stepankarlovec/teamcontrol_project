import 'dart:convert';
import 'package:app/models/defaultRequest.dart';
import 'package:app/models/profile.dart';
import 'package:app/config/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/UserForeign.dart';
import '../../../providers/provider_user.dart';

Future<List<UserForeign>> getTeammates(context) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/team/${Provider.of<User>(context, listen: false).teamId}/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<UserForeign> users = (jsonResponse['users'] as List<dynamic>)
        .map((json) => UserForeign.fromJson(json))
        .toList();
    return users;
  } else {
    throw Exception("Something went wrong.");
  }
}
