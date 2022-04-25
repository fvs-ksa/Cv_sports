// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

VoteResult welcomeFromJson(String str) => VoteResult.fromJson(json.decode(str));

String welcomeToJson(VoteResult data) => json.encode(data.toJson());

class VoteResult {
  VoteResult({
    this.totalAnswers,
    this.answer,
  });

  int totalAnswers;
  List<Answer> answer;

  factory VoteResult.fromJson(Map<String, dynamic> json) => VoteResult(
    totalAnswers: json["TotalAnswers"],
    answer: List<Answer>.from(json["Answer"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TotalAnswers": totalAnswers,
    "Answer": List<dynamic>.from(answer.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    this.id,
    this.answer,
    this.countResult,
    this.countResultPercentage,
  });

  int id;
  String answer;
  int countResult;
  double countResultPercentage;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: json["id"],
    answer: json["answer"],
    countResult: json["count_result"],
    countResultPercentage: json["count_result_percentage"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "answer": answer,
    "count_result": countResult,
    "count_result_percentage": countResultPercentage,
  };
}
