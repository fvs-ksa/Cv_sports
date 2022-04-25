// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<AdvertismentsApi> welcomeFromJson(String str) => List<AdvertismentsApi>.from(json.decode(str).map((x) => AdvertismentsApi.fromJson(x)));

String welcomeToJson(List<AdvertismentsApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdvertismentsApi {
  AdvertismentsApi({
    this.id,
    this.link,
    this.image,
  });

  int id;
  String link;
  String image;

  factory AdvertismentsApi.fromJson(Map<String, dynamic> json) => AdvertismentsApi(
    id: json["id"] == null ? null : json["id"],
    link: json["link"] == null ? null : json["link"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "link": link == null ? null : link,
    "image": image == null ? null : image,
  };
}
