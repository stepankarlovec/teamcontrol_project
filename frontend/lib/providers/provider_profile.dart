import 'package:app/models/profile.dart';
import 'package:flutter/cupertino.dart';


class ProfileProvider extends ChangeNotifier{
  String? firstName;
  String? lastName;
  int? height;
  int? weight;
  String? position;

  void update(Profile res){
    firstName=res.firstName;
    lastName=res.lastName;
    height=res.height;
    weight=res.weight;
    notifyListeners();
  }
}