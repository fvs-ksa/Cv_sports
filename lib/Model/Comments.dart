

class Comments {
  Comments({
    this.id,
    this.body,
    this.created,
    this.userName,
    this.userAvatar,
    this.userId,

  });
  int userId;

  int id;
  String body;
  String created;
  String userName;
  String userAvatar;

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    id: json["id"],
    body: json["body"],
    created:json["created"],
    userName: json["user_name"],
    userAvatar: json["user_avatar"],
    userId: json["user_id"] == null ? null : json["user_id"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "body": body,
    "created": created,
    "user_name": userName,
    "user_id": userId ,
    "user_avatar": userAvatar,
  };
}
