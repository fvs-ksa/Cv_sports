// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GetRooms welcomeFromJson(String str) => GetRooms.fromJson(json.decode(str));

String welcomeToJson(GetRooms data) => json.encode(data.toJson());

class GetRooms {
  GetRooms({
    this.rooms,
    this.unseenRoomsCount,
  });

  List<Room> rooms;
  int unseenRoomsCount;

  factory GetRooms.fromJson(Map<String, dynamic> json) => GetRooms(
    rooms: json["rooms"] == null ? null : List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
    unseenRoomsCount: json["unseenRoomsCount"] == null ? null : json["unseenRoomsCount"],
  );

  Map<String, dynamic> toJson() => {
    "rooms": rooms == null ? null : List<dynamic>.from(rooms.map((x) => x.toJson())),
    "unseenRoomsCount": unseenRoomsCount == null ? null : unseenRoomsCount,
  };
}

class Room {
  Room({
    this.id,
    this.created,
    this.lastUpdate,
    this.lastMessage,
    this.members,
    this.closed,
  });

  int id;
  String created;
  DateTime lastUpdate;
  LastMessage lastMessage;
  List<Member> members;
  int closed;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json["id"] == null ? null : json["id"],
    created: json["created"] == null ? null : json["created"],
    lastUpdate: json["last_update"] == null ? null : DateTime.parse(json["last_update"]),
    lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
    members: json["members"] == null ? null : List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
    closed: json["closed"] == null ? null : json["closed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "created": created == null ? null : created,
    "last_update": lastUpdate == null ? null : lastUpdate.toIso8601String(),
    "last_message": lastMessage == null ? null : lastMessage.toJson(),
    "members": members == null ? null : List<dynamic>.from(members.map((x) => x.toJson())),
    "closed": closed == null ? null : closed,
  };
}

class LastMessage {
  LastMessage({
    this.id,
    this.message,
    this.created,
    this.sender,
  });

  int id;
  String message;
  String created;
  Member sender;

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json["id"] == null ? null : json["id"],
    message: json["message"] == null ? null : json["message"],
    created: json["created"] == null ? null : json["created"],
    sender: json["sender"] == null ? null : Member.fromJson(json["sender"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "message": message == null ? null : message,
    "created": created == null ? null : created,
    "sender": sender == null ? null : sender.toJson(),
  };
}

class Member {
  Member({
    this.id,
    this.name,
    this.role,
    this.avatar,
    this.seen,
  });

  int id;
  String name;
  String role;
  String avatar;
  int seen;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    role: json["role"] == null ? null : json["role"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    seen: json["seen"] == null ? null : json["seen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "role": role == null ? null : role,
    "avatar": avatar == null ? null : avatar,
    "seen": seen == null ? null : seen,
  };
}
