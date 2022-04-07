import 'package:flutter/foundation.dart';

class QuizManipulation {
  String name;
  String description;
  String categoryId;
  String status;

  QuizManipulation({
    @required this.name,
    @required this.description,
    @required this.categoryId,
    @required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "categoryId": categoryId,
      "status": status
    };
  }
}
