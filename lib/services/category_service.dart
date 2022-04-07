import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/CategoryNew.dart';
import '../model/Responce.dart';

class CategoryService {
  static const API = 'https://word-quiz-app-backend.herokuapp.com/category/';
  static const headers = {
    'Content-Type': 'application/json'
  };
    Future<Response> save(String username, CategoryRequestModel requestModel) async {
      print(requestModel);
      final responce = await http.post(
        Uri.parse(API+username+'/save'),
        headers: headers,
        body: jsonEncode(requestModel.toJson()),
      );
      print(jsonDecode(responce.body));
      if (responce.statusCode == 201 ||
          responce.statusCode == 401 ||
          responce.statusCode == 422) {
        return Response.fromJson(jsonDecode(responce.body));
      } else {
        throw Exception("Failed to Save Data");
      }
    }

    Future<List<CategoryNew>> getAllCategory() async {
      print(API+'all');
      final response = await http.get(Uri.parse(API+'all'));
      print(response);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        //final Cat = <CategoryNew>[];
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
      Uri.parse(API+id),
      headers: headers,
    );
    print(jsonDecode(responce.body));
    if (responce.statusCode == 201 ||
        responce.statusCode == 422) {
      return Response.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception("Failed to Delete Data");
    }
  }

  Future<Response> update(String id, String username, CategoryRequestModel requestModel) async {
    print(requestModel);
    print(id+ username);
    final responce = await http.put(
      Uri.parse(API+username+'/'+id),
      headers: headers,
      body: jsonEncode(requestModel.toJson()),
    );
    print(jsonDecode(responce.body));
    if (responce.statusCode == 200 ||
        responce.statusCode == 422) {
      return Response.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception("Failed to Update Data");
    }
  }
}