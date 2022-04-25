
import 'dart:convert';

List<CountryApi> welcomeFromJson(String str) => List<CountryApi>.from(json.decode(str).map((x) => CountryApi.fromJson(x)));

String welcomeToJson(List<CountryApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryApi {
  CountryApi({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory CountryApi.fromJson(Map<String, dynamic> json) => CountryApi(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
