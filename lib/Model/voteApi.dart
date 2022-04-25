
class VoteQuestion {
  VoteQuestion({
    this.id,
    this.question,
    this.answers,
    this.dynamicLink
  });
  String dynamicLink;
  int id;
  String question;
  List<Answer> answers;

  factory VoteQuestion.fromJson(Map<String, dynamic> json) => VoteQuestion(
    id: json["id"],
    question: json["question"],
      dynamicLink :json["dynamic_link"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "dynamic_link":dynamicLink,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    this.id,
    this.answer,
    this.icon,
  });

  int id;
  String answer;
  String icon;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: json["id"] == null ? null : json["id"],
    answer: json["answer"] == null ? null : json["answer"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "answer": answer == null ? null : answer,
    "icon": icon == null ? null : icon,
  };
}
