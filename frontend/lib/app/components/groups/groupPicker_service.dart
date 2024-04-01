import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:app/config/globals.dart' as globals;
import 'package:http/http.dart' as http;
import '../../../models/group.dart';
import '../../../providers/provider_user.dart';

Future<List<Group>> getGroups(context) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/group/${Provider
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

    final List<dynamic> jsonList = json.decode(response.body);

    List<Group> groups = [];

    for (Map<String, dynamic> jsonMap in jsonList) {
      groups.add(Group.fromJson(jsonMap));
    }

    return groups;
  } else {
    print(response.body);
    throw Exception("Something went wrong.");
  }
}
