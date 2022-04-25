
class SportApi {
  SportApi({
    this.id,
    this.name,
    this.icon,
  });

  int id;
  String name;
  String icon;

  factory SportApi.fromJson(Map<String, dynamic> json) => SportApi(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
  };
}