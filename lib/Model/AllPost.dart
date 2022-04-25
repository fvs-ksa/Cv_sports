
import 'dart:convert';

class AllPost {
  AllPost({
    this.id,
    this.body,
    this.userId,
    this.userName,
    this.userAvatar,
    this.isLiked,
    this.commentCount,
    this.likeCount,
    this.isCommentable,
    this.media,
    this.created,
  });

  int id;
  String body;
  int userId;
  String userName;
  String userAvatar;
  bool isLiked;
  int commentCount;
  int likeCount;
  bool isCommentable;
  List<Media> media;
  String created;

  factory AllPost.fromJson(Map<String, dynamic> json) => AllPost(
    id: json["id"],
    body: json["body"],
    userId: json["user_id"],
    userName: json["user_name"],
    userAvatar: json["user_avatar"],
    isLiked: json["is_liked"],
    commentCount: json["comment_count"],
    likeCount: json["like_count"],
    isCommentable: json["is_commentable"],
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
    created: json["created"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "body": body,
    "user_id": userId,
    "user_name": userName,
    "user_avatar": userAvatar,
    "is_liked": isLiked,
    "comment_count": commentCount,
    "like_count": likeCount,
    "is_commentable": isCommentable,
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
    "created": created,
  };
}

class Media {
  Media({
    this.id,
    this.path,
    this.type,
  });

  int id;
  String path;
  Type type;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"],
    path: json["path"],
    type: typeValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "path": path,
    "type": typeValues.reverse[type],
  };
}

enum Type { IMAGE, VIDEO }

final typeValues = EnumValues({
  "image": Type.IMAGE,
  "video": Type.VIDEO
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
