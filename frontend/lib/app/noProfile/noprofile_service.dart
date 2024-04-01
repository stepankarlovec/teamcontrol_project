import 'dart:convert';
import 'package:app/models/defaultRequest.dart';
import 'package:app/models/profile.dart';
import 'package:app/config/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../models/error.dart';
import '../../providers/provider_user.dart';

/*TODO implement profile provider update after login*/
Future<Object> editProfile(Profile profile, context) async {
  final response = await http.post(
    Uri.parse('${globals.SERVER_DOMAIN}/api/person/edit'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
    body: jsonEncode(<String, String>{
      'person_id': Provider.of<User>(context, listen: false).ID.toString(),
      'first_name': profile.firstName,
      'last_name': profile.lastName,
      'height': profile.height.toString(),
      'weight': profile.weight.toString(),
      'position': profile.position??'',
    }),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    return DefaultRequest.fromJson(jsonDecode(response.body));
  } else {
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
    return Profile.fromJson(jsonDecode(response.body), 0);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.body),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    ));
    throw Exception("Something went wrong.");
  }
}
