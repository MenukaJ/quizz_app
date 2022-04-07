import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/model/category.dart';

final quizzes = <Category>[
  Category(
    questions: questions,
    categoryName: 'Quizz 1',
    imageUrl: 'assets/maths.png',
    backgroundColor: Colors.blue,
    icon: FontAwesomeIcons.language,
    description: 'Practice questions from various chapters in physics',
  ),
  Category(
    questions: questions,
    imageUrl: 'assets/maths.png',
    categoryName: 'Quizz 2',
    backgroundColor: Colors.orange,
    icon: FontAwesomeIcons.atom,
    description: 'Practice questions from various chapters in chemistry',
  ),
  Category(
    questions: questions,
    imageUrl: 'assets/maths.png',
    categoryName: 'Quizz 4',
    backgroundColor: Colors.purple,
    icon: FontAwesomeIcons.squareRootAlt,
    description: 'Practice questions from various chapters in maths',
  ),
  Category(
    questions: questions,
    imageUrl: 'assets/maths.png',
    categoryName: 'Quizz 3',
    backgroundColor: Colors.lightBlue,
    icon: FontAwesomeIcons.dna,
    description: 'Practice questions from various chapters in biology',
  ),
];
