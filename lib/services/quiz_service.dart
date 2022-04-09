import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/quiz/quiz.dart';
import 'package:quiz_app/quiz/quiz_api_response.dart';
import 'package:quiz_app/quiz/quiz_for_listing.dart';
import 'package:quiz_app/quiz/quiz_insert.dart';

class QuizService {
  static const API = 'https://word-quiz-app-backend.herokuapp.com';
  static const headers = {
    'Content-Type': 'application/json'
  };

  Future<QuizAPIResponse<List<QuizForListing>>> getQuizList() {
    return http.get(API + '/quiz/all').then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final quizzes = <QuizForListing>[];
        for (var item in jsonData) {
          quizzes.add(QuizForListing.fromJson(item));
        }
        return QuizAPIResponse<List<QuizForListing>>(data: quizzes);
      }
      return QuizAPIResponse<List<QuizForListing>>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => QuizAPIResponse<List<QuizForListing>>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<QuizAPIResponse<Quiz>> getQuiz(String quizID) {
    return http.get(API + '/quiz/'+quizID).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return QuizAPIResponse<Quiz>(data: Quiz.fromJson(jsonData));
      }
      return QuizAPIResponse<Quiz>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => QuizAPIResponse<Quiz>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<QuizAPIResponse<bool>> createQuiz(QuizManipulation item) {
    return http.post(API + '/quiz/ADMIN/save', headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return QuizAPIResponse<bool>(data: true);
      }
      return QuizAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => QuizAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<QuizAPIResponse<bool>> updateQuiz(String quizID, QuizManipulation item) {
    return http.put(API + '/quiz/ADMIN/'+quizID, headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 200) {
        return QuizAPIResponse<bool>(data: true);
      }
      return QuizAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => QuizAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<QuizAPIResponse<bool>> deleteQuiz(String quizID) {
    return http.delete(API + '/quiz/'+quizID).then((data) {
      if (data.statusCode == 201) {
        return QuizAPIResponse<bool>(data: true);
      }
      return QuizAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => QuizAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }
}
