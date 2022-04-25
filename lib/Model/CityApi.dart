// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<CityApi> welcomeFromJson(String str) => List<CityApi>.from(json.decode(str).map((x) => CityApi.fromJson(x)));

String welcomeToJson(List<CityApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityApi {
  CityApi({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory CityApi.fromJson(Map<String, dynamic> json) => CityApi(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
