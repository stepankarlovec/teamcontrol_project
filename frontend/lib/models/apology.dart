/*
            'name' => $request->name,
            'text' => $request->text,
            'dateFrom' => $request->dateFrom,
            'dateUntil' => $request->dateUntil,
            'user_id' => $request->user_id,
            'event_id' => $request->event_id,
 */

class Apology {
  int? id;
  String name;
  String text;
  DateTime dateFrom;
  DateTime dateUntil;
  int userId;
  int? teamId;

  Apology({
    required this.name,
    required this.text,
    required this.dateFrom,
    required this.dateUntil,
    required this.userId,
    this.teamId,
    this.id,
  });

  factory Apology.fromJson(Map<String,dynamic> json) {
    DateTime dateFrom = DateTime.parse(json["dateFrom"]);
    DateTime dateUntil = DateTime.parse(json["dateUntil"]);

    return Apology(
      id: json["id"],
      name: json["name"],
      text: json["text"],
      dateFrom: dateFrom,
      dateUntil: dateUntil,
      userId: json["user_id"],
      teamId: json["team_id"],
    );
  }

}