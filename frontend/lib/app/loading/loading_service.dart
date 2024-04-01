import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/config/globals.dart' as globals;
import 'dart:async';

class UserAuthDataModel {
  final int ID;
  final String email;
  final DateTime? emailVerified;
  final int? teamId;
  final int personId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String bearerToken;
  final int role;


  UserAuthDataModel({
    required this.ID,
    required this.email,
    required this.emailVerified,
    required this.teamId,
    required this.personId,
    required this.createdAt,
    required this.updatedAt,
    required this.bearerToken,
    required this.role,
  });

  factory UserAuthDataModel.fromJson(Map<String, dynamic> json, token) {
    return UserAuthDataModel(
        ID: json['id'],
        email: json['email'],
        emailVerified: json['email_verified_at']!=null ? DateTime.parse(json['email_verified_at']) : null,
        teamId: json['team_id'],
        personId: json['person_id'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        role: json['role'],
        bearerToken: token,
    );
  }
}

Future<UserAuthDataModel> tryToAuth(BuildContext context, String token) async {
  try {
    final response = await http.get(Uri.parse('${globals.SERVER_DOMAIN}/api/auth'), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return UserAuthDataModel.fromJson(jsonDecode(response.body), token);
    } else {
      throw Exception("Failed validating user with token $token");
    }
  }catch(err){
    print("exeption happens");
    throw Exception("Can't connect to the server, check your internet connection.");
  }
}
