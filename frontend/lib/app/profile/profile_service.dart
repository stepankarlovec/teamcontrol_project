import 'dart:convert';
import 'package:app/app/auth/login/login_widget.dart';
import 'package:app/app/loading/loading_service.dart';
import 'package:app/models/defaultRequest.dart';
import 'package:app/models/profile.dart';
import 'package:app/config/globals.dart' as globals;
import 'package:app/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../models/error.dart';
import '../../providers/provider_user.dart';
import '../homepage/homepage.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Profile edited successfully"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Homepage()));
    return DefaultRequest.fromJson(jsonDecode(response.body));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("ERROR - Something went wrong."),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
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
    throw Exception("Something went wrong.");
  }
}

logout(context) async {
  const storage = FlutterSecureStorage();
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("Successfully logged out."),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 3),
  ));
  await storage.deleteAll().then((v) => {
  Provider.of<User>(context, listen: false).update(UserAuthDataModel(ID: 0, email: "delete@delete.com", emailVerified: DateTime.now(), teamId: 0, personId: 0, createdAt: DateTime.now(), updatedAt: DateTime.now(), bearerToken: "", role: 0)),
    Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const LoginPage()))
  });
}



Future deleteAccount(context) async {
  final response = await http.delete(
    Uri.parse('${globals.SERVER_DOMAIN}/api/user/delete'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
  );
print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    var req = DefaultRequest.fromJson(jsonDecode(response.body));
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(req.message),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LoginWidget()));
  } else {
    var req = ErrorRequest.fromJson(jsonDecode(response.body));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(req.message),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }
}