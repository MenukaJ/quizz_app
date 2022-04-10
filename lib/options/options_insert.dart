import 'package:flutter/foundation.dart';

class OptionsManipulation {
  String questionId;
  String name;
  String code;
  String isCorrect;
  String status;

  OptionsManipulation({
    @required this.questionId,
    @required this.name,
    @required this.code,
    @required this.isCorrect,
    @required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "questionId": questionId,
      "name": name,
      "code": code,
      "isCorrect": isCorrect,
      "status": status
    };
  }
}