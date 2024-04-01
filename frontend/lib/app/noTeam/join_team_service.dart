import 'dart:convert';

import 'package:app/models/defaultRequest.dart';
import 'package:app/models/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../models/profile.dart';
import '../../providers/provider_user.dart';
import '../auth/login/login_service.dart';
import 'package:app/config/globals.dart' as globals;
import 'package:app/models/invitation.dart';
import 'package:http/http.dart' as http;

import '../event/newEvent/new_event_service.dart';
import '../homepage/homepage.dart';
import '../loading/loading_service.dart';
import '../noProfile/noprofile_widget.dart';

Future CodeVerifyRequest(String code, context) async {
  final response = await http.post(
    Uri.parse('${globals.SERVER_DOMAIN}/api/invitation'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Provider.of<User>(context, listen: false).bearerToken}',
    },
    body: jsonEncode(<String, String>{
      'code': code,
    }),
  );

  print(response.body);
  if (response.statusCode == 201) {
    DefaultRequest res = DefaultRequest.fromJson(jsonDecode(response.body));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res.message),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));


    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'jwt');

    tryToAuth(context, value!).then((UserAuthDataModel res) {
      context.read<User>().update(res);
    });

    if(getProfile(context) is Profile){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Homepage()));
    }else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NoProfileWidget()));
    }

  } else {
    ErrorRequest err = ErrorRequest.fromJson(jsonDecode(response.body));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(err.message ?? "Something went wrong"),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }
}