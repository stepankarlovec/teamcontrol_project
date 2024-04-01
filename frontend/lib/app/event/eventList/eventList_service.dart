import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:app/config/globals.dart' as globals;
import '../../../models/event.dart';
import '../../../providers/provider_user.dart';

Future<List<Event>> getAllEvents(context) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/allEvents'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
  );
print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    if (jsonList.isNotEmpty) {
      List<Event> events = jsonList.map((json) => Event.fromJson(json)).toList();
      print(events.isNotEmpty ? events[0] : "No events found");
      return events;
    } else {
      print("No events found");
      return []; // Return an empty list if no events are found
    }
  } else {
    return []; // Return an empty list if no events are found
  }
}
