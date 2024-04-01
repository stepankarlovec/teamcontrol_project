class Group{
  int? id;
  final String name;
  final String users;
  final int permanent;
  int? team_id;

  Group({
    required this.name,
    required this.users,
    required this.permanent,
    this.team_id,
    this.id
  });

  factory Group.fromJson(Map<String,dynamic> json) {
    return Group(
      id: int.parse(json["id"].toString()),
      name: json["name"],
      users: json["users"],
      permanent: int.parse(json["permanent"].toString()),
      team_id: int.parse(json["team_id"].toString()),
    );
  }
}