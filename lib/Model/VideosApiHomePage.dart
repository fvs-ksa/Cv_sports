
class Videos {
  Videos({
    this.id,
    this.title,
    this.video,
  });

  int id;
  String title;
  String video;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
    id: json["id"],
    title: json["title"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "video": video,
  };
}
