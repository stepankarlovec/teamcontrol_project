import 'dart:convert';

import 'package:app/config/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../models/team.dart';
import '../../../providers/provider_user.dart';
import '../../loading/loading_service.dart';

class CreateTeamResponse {

  String message;
  Team team;

  CreateTeamResponse({
    required this.message,
    required this.team
});

  factory CreateTeamResponse.fromJson(Map<String, dynamic> json) {
    return CreateTeamResponse(
        message: json["message"],
        team: Team(
            id: json["team"]["id"],
            name: json["team"]["name"],
            country: json["team"]["country"]));
  }
}

Future<CreateTeamResponse> createTeamRequest(String token, String name, String country, context) async {
  final response = await http.post(
    Uri.parse('${globals.SERVER_DOMAIN}/api/team'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'country': country,
    }),
  );

  print(response.body);

  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successfully created a team"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'jwt');

    tryToAuth(context, value!).then((UserAuthDataModel res) {
      context.read<User>().update(res);
    });

    return CreateTeamResponse.fromJson(jsonDecode(response.body));
  } else {
    return CreateTeamResponse.fromJson(jsonDecode(response.body));
  }
}
