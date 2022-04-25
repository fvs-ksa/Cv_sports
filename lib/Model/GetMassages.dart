
class GetMassages {
  GetMassages({
    this.messages,
  });

  List<Message> messages;

  factory GetMassages.fromJson(Map<String, dynamic> json) => GetMassages(
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class Message {
  Message({
    this.id,
    this.message,
    this.created,
    this.sender,
  });

  int id;
  String message;
  String created;
  Sender sender;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    message: json["message"],
    created: json["created"],
    sender: Sender.fromJson(json["sender"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "created": created,
    "sender": sender.toJson(),
  };
}

class Sender {
  Sender({
    this.id,
    this.name,
    this.avatar,
  });

  int id;
  String name;
  String avatar;

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
  };
}
