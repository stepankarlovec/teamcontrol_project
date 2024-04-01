import 'dart:convert';

import 'package:app/app/admin/dashboard/adminDashboard_widget.dart';
import 'package:app/models/apology.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:app/config/globals.dart' as globals;
import '../../../providers/provider_user.dart';

Future<List<Apology>> getAllApologies(context) async {
  final response = await http.get(
    Uri.parse('${globals.SERVER_DOMAIN}/api/apologies/${Provider.of<User>(context, listen: false).teamId}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
  );
  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    if (jsonList.isNotEmpty) {
      List<Apology> apologies = jsonList.map((json) => Apology.fromJson(json)).toList();
      print(apologies.isNotEmpty ? apologies[0] : "No apologies found");
      return apologies;
    } else {
      print("No apologies found");
      return []; // Return an empty list if no events are found
    }
  } else {
    return []; // Return an empty list if no events are found
  }
}

Future<Future> deleteApology(context, int id) async {
  final response = await http.delete(
    Uri.parse('${globals.SERVER_DOMAIN}/api/apology/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider
          .of<User>(context, listen: false)
          .bearerToken}',
    },
  );

  if (response.statusCode == 200) {
    print(response.body);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Apology deleted."),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const AdminDashboardWidget()));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Error."),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AdminDashboardWidget()));
  }
}
