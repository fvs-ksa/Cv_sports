

class Following {
  Following({
    this.count,
    this.postCount,
    this.records,
  });

  int count;
  int postCount;
  List<Record> records;

  factory Following.fromJson(Map<String, dynamic> json) => Following(
    count: json["count"],
    postCount: json["post_count"],
    records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "post_count": postCount,
    "records": List<dynamic>.from(records.map((x) => x.toJson())),
  };
}

class Record {
  Record({
    this.isFollowed,
    this.userId,
    this.name,
    this.avatar,
    this.role,
  });

  bool isFollowed;
  int userId;
  String name;
  String avatar;
  String role;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    isFollowed: json["is_followed"],
    userId: json["user_id"],
    name: json["name"],
    avatar: json["avatar"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "is_followed": isFollowed,
    "user_id": userId,
    "name": name,
    "avatar": avatar,
    "role": role,
  };
}



