// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'AllPost.dart';

List<Users> welcomeFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String welcomeToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    this.active,
    this.phoneOne,
    this.phoneTwo,
    this.id,
    this.name,
    this.email,

    this.gender,
    this.birthdate,
    this.role,
    this.sport,
    this.avatar,
    this.posts,
    this.city,
    this.country,
    this.extraDetails,
    this.clubDetails,
    this.playerDetails,
    this.medals,
    this.prizes,
    this.images,
    this.isFollowed,
    this.userFollowers,
    this.userFollowing,
    this.socialLinks,
  });
  bool active;
  String phoneOne;
  String phoneTwo;
  bool isFollowed;
  SocialLinks socialLinks;
  int userFollowers;
  int userFollowing;
  int id;
  String name;
  String email;
  Gender gender;
  DateTime birthdate;
  Role role;
  Sport sport;
  String avatar;
  List<AllPost> posts;
  City city;
  City country;
  ExtraDetails extraDetails;
  ClubDetails clubDetails;
  PlayerDetails playerDetails;
  List<Medal> medals;
  List<Prize> prizes;
  List<ImagesUser> images;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    active: json["active"] == null ? null : json["active"],
    phoneOne: json["phone_one"] == null ? null : json["phone_one"],
    phoneTwo: json["phone_two"] == null ? null : json["phone_two"],
        id: json["id"] == null ? null : json["id"],
        images: json["images"] == null ? null : List<ImagesUser>.from(json["images"].map((x) => ImagesUser.fromJson(x))),
    isFollowed: json["is_followed"],
        userFollowers: json["user_followers"],
        userFollowing: json["user_following"],
        socialLinks: json["social_links"] == null
            ? null
            : SocialLinks.fromJson(json["social_links"]),
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        gender:
            json["gender"] == null ? null : genderValues.map[json["gender"]],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        sport: json["sport"] == null ? null : Sport.fromJson(json["sport"]),
        avatar: json["avatar"] == null ? null : json["avatar"],
        posts: json["posts"] == null
            ? null
            : List<AllPost>.from(json["posts"].map((x) => AllPost.fromJson(x))),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        country:
            json["country"] == null ? null : City.fromJson(json["country"]),
        extraDetails: json["extra_details"] == null
            ? null
            : ExtraDetails.fromJson(json["extra_details"]),
        clubDetails: json["club_details"] == null
            ? null
            : ClubDetails.fromJson(json["club_details"]),
        playerDetails: json["player_details"] == null
            ? null
            : PlayerDetails.fromJson(json["player_details"]),
        medals: json["medals"] == null
            ? null
            : List<Medal>.from(json["medals"].map((x) => Medal.fromJson(x))),
        prizes: json["prizes"] == null
            ? null
            : List<Prize>.from(json["prizes"].map((x) => Prize.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "phone_one": phoneOne == null ? null : phoneOne,
    "phone_two": phoneTwo == null ? null : phoneTwo,
    "id": id == null ? null : id,
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x.toJson())),
    "is_followed": isFollowed,
    "user_followers": userFollowers,
    "user_following": userFollowing,
    "social_links": socialLinks == null ? null : socialLinks.toJson(),
    "active": active == null ? null : active,

    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "gender": gender == null ? null : genderValues.reverse[gender],
    "birthdate": birthdate == null ? null : "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
    "role": role == null ? null : role.toJson(),
    "sport": sport == null ? null : sport.toJson(),
    "avatar": avatar == null ? null : avatar,
    "posts": posts == null ? null : List<dynamic>.from(posts.map((x) => x.toJson())),
    "city": city == null ? null : city.toJson(),
    "country": country == null ? null : country.toJson(),
    "extra_details": extraDetails == null ? null : extraDetails.toJson(),
    "club_details": clubDetails == null ? null : clubDetails.toJson(),
    "player_details": playerDetails == null ? null : playerDetails.toJson(),
    "medals": medals == null ? null : List<dynamic>.from(medals.map((x) => x.toJson())),
    "prizes": prizes == null ? null : List<dynamic>.from(prizes.map((x) => x.toJson())),
  };
}
class SocialLinks {
  SocialLinks({
    this.facebook,
    this.instagram,
    this.snapchat,
    this.twitter,
    this.youtube,
  });

  String facebook;
  String instagram;
  String snapchat;
  String twitter;
  String youtube;

  factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
    facebook: json["facebook"] == null ? null : json["facebook"],
    instagram: json["instagram"] == null ? null : json["instagram"],
    snapchat: json["snapchat"] == null ? null : json["snapchat"],
    twitter: json["twitter"] == null ? null : json["twitter"],
    youtube: json["youtube"] == null ? null : json["youtube"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook == null ? null : facebook,
    "instagram": instagram == null ? null : instagram,
    "snapchat": snapchat == null ? null : snapchat,
    "twitter": twitter == null ? null : twitter,
    "youtube": youtube == null ? null : youtube,
  };
}
class ImagesUser {
  ImagesUser({
    this.id,
    this.path,
    this.type,
  });

  int id;
  String path;
  String type;

  factory ImagesUser.fromJson(Map<String, dynamic> json) => ImagesUser(
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
class City {
  City({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

class ClubDetails {
  ClubDetails({
    this.name,
    this.creationDate,
    this.place,
    this.phone,
    this.icon,
  });

  String name;
  DateTime creationDate;
  String place;
  dynamic phone;
  String icon;

  factory ClubDetails.fromJson(Map<String, dynamic> json) => ClubDetails(
    name: json["name"] == null ? null : json["name"],
    creationDate: json["creation_date"] == null ? null : DateTime.parse(json["creation_date"]),
    place: json["place"] == null ? null : json["place"],
    phone: json["phone"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "creation_date": creationDate == null ? null : "${creationDate.year.toString().padLeft(4, '0')}-${creationDate.month.toString().padLeft(2, '0')}-${creationDate.day.toString().padLeft(2, '0')}",
    "place": place == null ? null : place,
    "phone": phone,
    "icon": icon == null ? null : icon,
  };
}

class ExtraDetails {
  ExtraDetails({
    this.workPlace,
    this.nationality,
    this.qualification,
    this.contractStartDate,
    this.contractEndDate,
    this.cv,
  });

  String workPlace;
  City nationality;
  String qualification;
  DateTime contractStartDate;
  DateTime contractEndDate;
  String cv;

  factory ExtraDetails.fromJson(Map<String, dynamic> json) => ExtraDetails(
        workPlace: json["work_place"] == null ? null : json["work_place"],
        nationality: json["nationality"] == null
            ? null
            : City.fromJson(json["nationality"]),
        qualification:
            json["qualification"] == null ? null : json["qualification"],
        contractStartDate: json["contract_start_date"] == null
            ? null
            : DateTime.parse(json["contract_start_date"]),
        contractEndDate: json["contract_end_date"] == null
            ? null
            : DateTime.parse(json["contract_end_date"]),
        cv: json["cv"] == null ? null : json["cv"],
      );

  Map<String, dynamic> toJson() =>
      {
        "work_place": workPlace == null ? null : workPlace,
        "nationality": nationality,
        "qualification": qualification == null ? null : qualification,
        "contract_start_date": contractStartDate == null
            ? null
            : "${contractStartDate.year.toString().padLeft(4, '0')}-${contractStartDate.month.toString().padLeft(2, '0')}-${contractStartDate.day.toString().padLeft(2, '0')}",
        "contract_end_date": contractEndDate == null
            ? null
            : "${contractEndDate.year.toString().padLeft(4, '0')}-${contractEndDate.month.toString().padLeft(2, '0')}-${contractEndDate.day.toString().padLeft(2, '0')}",
        "cv": cv == null ? null : cv,
      };
}

enum Gender { MALE, Female }

final genderValues = EnumValues({
  "male": Gender.MALE,
  "female": Gender.Female,
});

class Medal {
  Medal({
    this.medal,
    this.id,
    this.count,
  });

  String medal;
  int id;

  int count;

  factory Medal.fromJson(Map<String, dynamic> json) => Medal(
        medal: json["medal"] == null ? null : json["medal"],
        id: json["id"],
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "medal": medal == null ? null : medal,
        "id": id,
        "count": count == null ? null : count,
      };
}

class PlayerDetails {
  PlayerDetails({
    this.clubName,
    this.nationality,
    this.playerRole,
    this.playerStyle,
    this.height,
    this.weight,
    this.weightUnit,
    this.contractStartDate,
    this.contractEndDate,
    this.cv,
  });

  String clubName;
  City nationality;
  String playerRole;
  dynamic playerStyle;
  int height;
  int weight;
  WeightUnit weightUnit;
  DateTime contractStartDate;
  DateTime contractEndDate;
  String cv;

  factory PlayerDetails.fromJson(Map<String, dynamic> json) => PlayerDetails(
    clubName: json["club_name"] == null ? null : json["club_name"],
    nationality: json["nationality"] == null ? null : City.fromJson(json["nationality"]),
    playerRole: json["player_role"] == null ? null : json["player_role"],
    playerStyle: json["player_style"],
    height: json["height"] == null ? null : json["height"],
    weight: json["weight"] == null ? null : json["weight"],
    weightUnit: json["weight_unit"] == null ? null : weightUnitValues.map[json["weight_unit"]],
    contractStartDate: json["contract_start_date"] == null ? null : DateTime.parse(json["contract_start_date"]),
    contractEndDate: json["contract_end_date"] == null ? null : DateTime.parse(json["contract_end_date"]),
    cv: json["cv"] == null ? null : json["cv"],
  );

  Map<String, dynamic> toJson() => {
    "club_name": clubName == null ? null : clubName,
    "nationality": nationality == null ? null : nationality.toJson(),
    "player_role": playerRole == null ? null : playerRole,
    "player_style": playerStyle,
    "height": height == null ? null : height,
    "weight": weight == null ? null : weight,
    "weight_unit": weightUnit == null ? null : weightUnitValues.reverse[weightUnit],
    "contract_start_date": contractStartDate == null ? null : "${contractStartDate.year.toString().padLeft(4, '0')}-${contractStartDate.month.toString().padLeft(2, '0')}-${contractStartDate.day.toString().padLeft(2, '0')}",
    "contract_end_date": contractEndDate == null ? null : "${contractEndDate.year.toString().padLeft(4, '0')}-${contractEndDate.month.toString().padLeft(2, '0')}-${contractEndDate.day.toString().padLeft(2, '0')}",
    "cv": cv == null ? null : cv,
  };
}

enum WeightUnit { KG , PN}

final weightUnitValues = EnumValues({
  "kg": WeightUnit.KG,
  "pound": WeightUnit.PN,
});

class Post {
  Post({
    this.id,
    this.body,
    this.isLiked,
    this.commentCount,
    this.likeCount,
    this.media,
    this.created,
  });

  int id;
  String body;
  bool isLiked;
  int commentCount;
  int likeCount;
  List<Media> media;
  String created;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"] == null ? null : json["id"],
    body: json["body"] == null ? null : json["body"],
    isLiked: json["is_liked"] == null ? null : json["is_liked"],
    commentCount: json["comment_count"] == null ? null : json["comment_count"],
    likeCount: json["like_count"] == null ? null : json["like_count"],
    media: json["media"] == null ? null : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
    created: json["created"] == null ? null : json["created"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "body": body == null ? null : body,
    "is_liked": isLiked == null ? null : isLiked,
    "comment_count": commentCount == null ? null : commentCount,
    "like_count": likeCount == null ? null : likeCount,
    "media": media == null ? null : List<dynamic>.from(media.map((x) => x.toJson())),
    "created": created == null ? null : created,
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
    id: json["id"] == null ? null : json["id"],
    path: json["path"] == null ? null : json["path"],
    type: json["type"] == null ? null : typeValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "path": path == null ? null : path,
    "type": type == null ? null : typeValues.reverse[type],
  };
}

enum Type { IMAGE, VIDEO }

final typeValues = EnumValues({
  "image": Type.IMAGE,
  "video": Type.VIDEO
});

class Prize {
  Prize({
    this.prize,
    this.id,
    this.count,
  });

  String prize;
  int count;
  int id;

  factory Prize.fromJson(Map<String, dynamic> json) => Prize(
        prize: json["prize"] == null ? null : json["prize"],
        count: json["count"] == null ? null : json["count"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "prize": prize == null ? null : prize,
        "id": id,
        "count": count == null ? null : count,
      };
}

class Role {
  Role({
    this.id,
    this.name,
    this.profileType,
    this.hasSport,
    this.icon,
    this.news,
    this.userCount,
  });

  int id;
  String name;
  ProfileType profileType;
  int hasSport;
  String icon;
  bool news;
  int userCount;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name:json["name"],
    profileType: profileTypeValues.map[json["profile_type"]],
    hasSport: json["has_sport"],
    icon: json["icon"],
    news: json["news"],
    userCount: json["user_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "profile_type": profileTypeValues.reverse[profileType],
    "has_sport": hasSport,
    "icon": icon,
    "news": news,
    "user_count": userCount,
  };
}

enum Name { MEDICS, CLUBS, PLAYERS }

final nameValues = EnumValues({
  "Clubs": Name.CLUBS,
  "Medics": Name.MEDICS,
  "Players": Name.PLAYERS
});

enum ProfileType { EXTRA, CLUB, PLAYER }

final profileTypeValues = EnumValues({
  "club": ProfileType.CLUB, //1
  "extra": ProfileType.EXTRA,//0
  "player": ProfileType.PLAYER//2
});

class Sport {
  Sport({
    this.id,
    this.name,
    this.icon,
  });

  int id;
  String name;
  String icon;

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "icon": icon == null ? null : icon,
  };
}

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
