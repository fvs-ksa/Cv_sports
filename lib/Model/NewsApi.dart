
class NewsApi {
  NewsApi({
    this.id,
    this.title,
    this.content,
    this.userId,
    this.clubName,
    this.clubIcon,
    this.created,
    this.image,
  });

  int id;
  String title;
  String content;
  int userId;
  String clubName;
  String clubIcon;
  Created created;
  List<ImageNews> image;

  factory NewsApi.fromJson(Map<String, dynamic> json) => NewsApi(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    content: json["content"] == null ? null : json["content"],
    userId: json["user_id"] == null ? null : json["user_id"],
    clubName: json["club_name"] == null ? null : json["club_name"],
    clubIcon: json["club_icon"] == null ? null : json["club_icon"],
    created: json["created"] == null ? null : createdValues.map[json["created"]],
    image: json["image"] == null ? null : List<ImageNews>.from(json["image"].map((x) => ImageNews.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "content": content == null ? null : content,
    "user_id": userId == null ? null : userId,
    "club_name": clubName == null ? null : clubName,
    "club_icon": clubIcon == null ? null : clubIcon,
    "created": created == null ? null : createdValues.reverse[created],
    "image": image == null ? null : List<dynamic>.from(image.map((x) => x.toJson())),
  };
}

enum Created { THE_37_MINUTES_AGO }

final createdValues = EnumValues({
  "37 minutes ago": Created.THE_37_MINUTES_AGO
});

class ImageNews {
  ImageNews({
    this.id,
    this.path,
    this.type,
  });

  int id;
  String path;
 String type;

  factory ImageNews.fromJson(Map<String, dynamic> json) => ImageNews(
    id: json["id"] == null ? null : json["id"],
    path: json["path"] == null ? null : json["path"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "path": path == null ? null : path,
    "type": type == null ? null : type,
  };
}

enum Type { IMAGE , VIDEO}

final typeValues = EnumValues({
  "image": Type.IMAGE,
  "video" :Type.VIDEO,
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
