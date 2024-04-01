import 'dart:ffi';

class Event {
   int? id;
   String? individualParticipants;
   String? groups;
   String? color;
   String name;
   int duration;
   int repeated;
   DateTime date;
   String location;
   int creator_id;

  Event({
    required this.name,
    required this.date,
    required this.duration,
    required this.repeated,
    required this.color,
    required this.location,
    required this.creator_id,
    this.id,
    this.individualParticipants,
    this.groups
  });

  factory Event.fromJson(Map<String,dynamic> json) {
    DateTime date = DateTime.parse(json["date"]);

    return Event(
      id: json["id"],
      name: json["name"],
      location: json["location"],
      duration: json["duration"],
      repeated: json["repeated"],
      color: json["color"],
      creator_id: json["creator_id"],
      date: date,
    );
  }

}