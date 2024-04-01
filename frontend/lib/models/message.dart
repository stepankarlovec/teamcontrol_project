class Message {
  int? id;
  String? message;
  int? user_id;
  String? user_name;
  int? team_id;

  Message({
    this.id,
    this.message,
    this.team_id,
    this.user_id,
    this.user_name,
  });

  factory Message.fromJson(Map<String,dynamic> json) {
    return Message(
      id: json["id"],
      message: json["message"],
      user_id: json["user_id"],
      user_name: json["userName"],
      team_id: json["team_id"],
    );
  }

}