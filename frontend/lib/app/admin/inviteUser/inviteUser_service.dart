import 'dart:convert';
import 'package:app/config/globals.dart' as globals;
import 'package:app/models/invitation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../models/UserForeign.dart';
import '../../../providers/provider_user.dart';

Future<Invitation> getInvitationCode(context) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/invitation'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
  );

  if (response.statusCode == 201 || response.statusCode == 200) {

    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Invitation.fromJson(jsonResponse);

  } else {
    throw Exception("Something went wrong.");
  }
}