import 'package:flutter/cupertino.dart';

import '../app/loading/loading_service.dart';

class User extends ChangeNotifier{
  int? ID;
  String? email;
  DateTime? emailVerified;
  int? teamId;
  int? personId;
  DateTime? createdAt;
  DateTime? updatedAt;
  late String bearerToken;
  late int role;

  void update(UserAuthDataModel res){
    ID = res.ID;
    email = res.email;
    personId = res.personId;
    teamId = res.teamId;
    emailVerified = res.emailVerified;
    createdAt = res.createdAt;
    updatedAt = res.updatedAt;
    bearerToken = res.bearerToken;
    role = res.role;
    notifyListeners();
  }
}