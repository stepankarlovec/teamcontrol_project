import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:app/config/globals.dart' as globals;
import 'package:http/http.dart' as http;
import '../../../models/UserForeign.dart';
import '../../../providers/provider_user.dart';

Future<List<UserForeign>> getUsers(context) async {
  print('${globals.SERVER_DOMAIN}/api/team/${Provider
      .of<User>(context, listen: false)
      .teamId}');
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/team/${Provider
        .of<User>(context, listen: false)
        .teamId}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider
          .of<User>(context, listen: false)
          .bearerToken}',
    },
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    print(response.body);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<UserForeign> users = (jsonResponse['users'] as List<dynamic>)
        .map((json) => UserForeign.fromJson(json))
        .toList();
    return users;
  } else {
    print(response.body);
    throw Exception("Something went wrong.");
  }
}