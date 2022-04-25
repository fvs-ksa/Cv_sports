

class CustomDropMenu {
  CustomDropMenu({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory CustomDropMenu.fromJson(Map<String, dynamic> json) => CustomDropMenu(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
