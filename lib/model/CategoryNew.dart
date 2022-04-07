import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app_ii_example/model/question.dart';

class CategoryNew {
  final String id;
  final String name;
  final String description;
  final String backgroundColor;
  final String icon;
  final String status;

  //final List<Question> questions;
  final String imageUrl;

  CategoryNew({
    this.imageUrl,
    this.id,
    //@required this.questions,
    @required this.name,
    this.description,
    this.status,
    this.backgroundColor,
    this.icon,
  });

  factory CategoryNew.fromJson(Map<String, dynamic> json) {
    return CategoryNew(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageURL'],
      backgroundColor: json['backgroundColor'],
      status: json['status'],
    );
  }
}

class CategoryRequestModel {
  String name;
  String status;
  String description;
  String backgroundColor;
  String imageURL;
  String icon;

  CategoryRequestModel(
      {this.name,
        this.status,
        this.description,
        this.backgroundColor,
        this.imageURL,
        this.icon});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'status': status,
      'description': description,
      'backgroundColor': backgroundColor,
      'imageURL': imageURL,
      'icon': icon
    };
    return map;
  }
}

class CategoryListResponse<T> {
  T data;
  bool error;
  String errorMessage;

  CategoryListResponse({this.data, this.errorMessage, this.error = false});
}
