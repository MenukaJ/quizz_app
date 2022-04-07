import 'package:flutter/foundation.dart';

class QuestionManipulation {
  String quizId;
  String name;
  String solution;
  String isLocked;
  String status;

  QuestionManipulation({
    @required this.quizId,
    @required this.name,
    @required this.solution,
    @required this.isLocked,
    @required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "quizId": quizId,
      "name": name,
      "solution": solution,
      "isLocked": isLocked,
      "status": status
    };
  }
}
