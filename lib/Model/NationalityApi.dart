
import 'dart:convert';


class Nationality {
  Nationality({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Nationality.fromJson(Map<String, dynamic> json) => Nationality(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
