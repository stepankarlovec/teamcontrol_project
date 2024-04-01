class Profile {
  String firstName;
  String lastName;
  int height;
  int weight;
  String? position;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.height,
    required this.weight,
    required this.position,
  });

  factory Profile.fromJson(Map<String, dynamic> json, int type) {
    if(type==0) {
      return Profile(
        firstName: json['profile']['first_name'],
        lastName: json['profile']['last_name'],
        height: int.parse(json['profile']['height']),
        weight: int.parse(json['profile']['weight']),
        position: json['profile']['position'],
      );
    }else{
      return Profile(
        firstName: json['person']['first_name'],
        lastName: json['person']['last_name'],
        height: int.parse(json['person']['height']),
        weight: int.parse(json['person']['weight']),
        position: json['person']['position'],
      );
    }
  }
}
