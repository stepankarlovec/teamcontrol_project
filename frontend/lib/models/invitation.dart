class Invitation{
  int? id;
  String code;

  Invitation({
    required this.code,
    this.id
  });

  factory Invitation.fromJson(Map<String,dynamic> json) {
    return Invitation(
      code: json["code"].toString(),
    );
  }
}