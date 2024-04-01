import 'package:app/models/profile.dart';

class UserForeign{
  int ID;
  String email;
  int team_id;
  int person_id;
  Profile person;

  UserForeign({
    required this.ID,
    required this.email,
    required this.team_id,
    required this.person_id,
    required this.person
});

  factory UserForeign.fromJson(Map<String,dynamic> json) {

    return UserForeign(
      ID: json["id"],
      email: json["email"],
      team_id: json["team_id"],
      person_id: json["person_id"],
      /*TODO if profile not filled, there will be an error*/
      person: Profile.fromJson(json, 1),
    );
  }
}