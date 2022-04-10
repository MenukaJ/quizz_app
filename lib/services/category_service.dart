import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/category/category_api_response.dart';
import 'package:quiz_app/category/category_for_listing.dart';
import 'dart:convert';

import '../model/CategoryNew.dart';
import '../model/Responce.dart';
import '../model/category.dart';

class CategoryService {
  static const API = 'https://word-quiz-app-backend.herokuapp.com/category/';
  static const headers = {'Content-Type': 'application/json'};

  Future<Response> save(
      String username, CategoryRequestModel requestModel) async {
    print(requestModel);
    final responce = await http.post(
      Uri.parse(API + username + '/save'),
      headers: headers,
      body: jsonEncode(requestModel.toJson()),
    );
    print(jsonDecode(responce.body));
    if (responce.statusCode == 201 ||
        responce.statusCode == 422) {
      return Response.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception("Failed to Save Data");
    }
  }

  Future<List<CategoryNew>> getAllCategory() async {
    print(API + 'all');
    final response = await http.get(Uri.parse(API + 'all'));
    print(response);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<CategoryNew> categoies = [];
      for (var item in jsonData) {
        categoies.add(CategoryNew.fromJson(item));
      }
      print(categoies);
      return categoies;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Categories');
    }
  }

  Future<Response> delete(String id) async {
    final responce = await http.delete(
      Uri.parse(API + id),
      headers: headers,
    );
    print(jsonDecode(responce.body));
    if (responce.statusCode == 201 || responce.statusCode == 422) {
      return Response.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception("Failed to Delete Data");
    }
  }

  Future<Response> update(
      String id, String username, CategoryRequestModel requestModel) async {
    print(requestModel);
    print(id + username);
    final responce = await http.put(
      Uri.parse(API + username + '/' + id),
      headers: headers,
      body: jsonEncode(requestModel.toJson()),
    );
    print(jsonDecode(responce.body));
    if (responce.statusCode == 200 || responce.statusCode == 422) {
      return Response.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception("Failed to Update Data");
    }
  }

  Future<CategoryAPIResponse<List<CategoryForListing>>> getCategoryList() {
    return http.get(API + '/all').then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final categories = <CategoryForListing>[];
        for (var item in jsonData) {
          categories.add(CategoryForListing.fromJson(item));
        }
        return CategoryAPIResponse<List<CategoryForListing>>(data: categories);
      }
      return CategoryAPIResponse<List<CategoryForListing>>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => CategoryAPIResponse<List<CategoryForListing>>(error: true, errorMessage: 'An error occurred from API'));
  }

  /*  Future<List<Category>> getAllCategoryNew() async {
    print(API + 'all');
    final response = await http.get(Uri.parse(API + 'all'));
    print(response);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      //final Cat = <CategoryNew>[];
      //List<CategoryNew>  = [];
      final categories = <Category>[];
      for (var item in jsonData) {
        CategoryNew categoryNew = (CategoryNew.fromJson(item));
        final cat =  Category(
          questions: null,
          categoryName: categoryNew.name,
          imageUrl: categoryNew.imageUrl,
          backgroundColor: _getBackgroundColor(categoryNew.backgroundColor),
          icon: FontAwesomeIcons.rocket,
          description: categoryNew.description,
        );
        categories.add(cat);
      }
      print(categories);
      return categories;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Categories');
    }
  }*/

/*  Color _getBackgroundColor(String color) {
    if(color == 'Red')
      return Colors.red;
    else if(color == 'Green')
      return Colors.green;
    else if(color == 'Yellow')
      return Colors.yellow;
    else if(color == 'Blue')
      return Colors.blue;
    else if(color == 'Orange')
      return Colors.orange;
    else if(color == 'Purple')
      return Colors.purple;
    else
      return Colors.white;
  }*/
}

