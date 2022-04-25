

class NotificationApi {
  NotificationApi({
    this.unreadCount,
    this.notifications,
  });

  int unreadCount;
  List<NotificationOnly> notifications;

  factory NotificationApi.fromJson(Map<String, dynamic> json) => NotificationApi(
    unreadCount: json["unread_count"],
    notifications: List<NotificationOnly>.from(json["notifications"].map((x) => NotificationOnly.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "unread_count": unreadCount,
    "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
  };
}

class NotificationOnly {
  NotificationOnly({
    this.id,
    this.seen,
    this.message,
    this.createdAt,
  });

  int id;
  bool seen;
  String message;
  String createdAt;

  factory NotificationOnly.fromJson(Map<String, dynamic> json) => NotificationOnly(
    id: json["id"],
    seen: json["seen"],
    message: json["message"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seen": seen,
    "message": message,
    "created_at": createdAt,
  };
}




