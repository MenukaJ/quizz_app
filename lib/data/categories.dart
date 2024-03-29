import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/model/CategoryNew.dart';
import 'package:quiz_app/model/category.dart';

import '../services/category_service.dart';
/*CategoryService categoryService = new CategoryService();
List<Category> _apiResponse;
_fetchData() async {
 _apiResponse = await categoryService.getAllCategoryNew();
}

List<Category> getCategory() {
 return _apiResponse;
}*/
 final categories = <Category>[  Category(
    questions: questions,
    categoryName: 'Physics',
    imageUrl: 'assets/physics.png',
    backgroundColor: Colors.blue,
    icon: FontAwesomeIcons.rocket,
    description: 'Practice questions from various chapters in physics',
  ),
  Category(
    questions: questions,
    imageUrl: 'assets/chemistry.png',
    categoryName: 'Chemistry',
    backgroundColor: Colors.orange,
    icon: FontAwesomeIcons.atom,
    description: 'Practice questions from various chapters in chemistry',
  ),
  Category(
    questions: questions,
    imageUrl: 'assets/maths.png',
    categoryName: 'Maths',
    backgroundColor: Colors.purple,
    icon: FontAwesomeIcons.squareRootAlt,
    description: 'Practice questions from various chapters in maths',
  ),
  Category(
    questions: questions,
    imageUrl: 'assets/biology.png',
    categoryName: 'Biology',
    backgroundColor: Colors.lightBlue,
    icon: FontAwesomeIcons.dna,
    description: 'Practice questions from various chapters in biology',
  ),
  Category(
    questions: questions,
    imageUrl: 'assets/biology.png',
    categoryName: 'Sinhala',
    backgroundColor: Colors.red,
    icon: FontAwesomeIcons.language,
    description: 'Practice questions from various chapters in biology',
  ),
];
