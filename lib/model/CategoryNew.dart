import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app_ii_example/model/question.dart';

class CategoryNew {
  final String categoryName;
  final String description;
  final Color backgroundColor;
  final IconData icon;

  //final List<Question> questions;
  final String imageUrl;

  CategoryNew({
    @required this.imageUrl,
    //@required this.questions,
    @required this.categoryName,
    this.description = '',
    this.backgroundColor = Colors.orange,
    this.icon = FontAwesomeIcons.question,
  });

  factory CategoryNew.fromJson(Map<String, dynamic> json) {
    return CategoryNew(
      categoryName: json['firstName'],
      description: json['lastName'],
      backgroundColor: json['nic'],
      icon: json['email'],
      // username: json['username'],
    );
  }
}

class CategoryRequestModel {
  @required String name;
  @required String status;
  String description;
  String backgroundColor;
  @required String imageURL;
  String icon;

  CategoryRequestModel({this.name, this.status, this.description,
    this.backgroundColor, this.imageURL, this.icon});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {'name': name, 'status': status, 'description': description, 'backgroundColor': backgroundColor, 'imageURL': imageURL, 'icon': icon};
    return map;
  }
}
