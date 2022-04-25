
import 'dart:convert';

List<RolesSport> welcomeFromJson(String str) => List<RolesSport>.from(json.decode(str).map((x) => RolesSport.fromJson(x)));

String welcomeToJson(List<RolesSport> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RolesSport {
  RolesSport({
    this.id,
    this.name,
    this.profileType,
    this.icon,
    this.userCount,
  });

  int id;
  String name;
  ProfileType profileType;
  String icon;
  int userCount;

  factory RolesSport.fromJson(Map<String, dynamic> json) => RolesSport(
    id: json["id"],
    name: json["name"],
    profileType: profileTypeValues.map[json["profile_type"]],
    icon: json["icon"],
    userCount: json["user_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_type": profileTypeValues.reverse[profileType],
    "icon": icon,
    "user_count": userCount,
  };
}

enum ProfileType { PLAYER, EXTRA, CLUB }

final profileTypeValues = EnumValues({
  "club": ProfileType.CLUB,
  "extra": ProfileType.EXTRA,
  "player": ProfileType.PLAYER
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
