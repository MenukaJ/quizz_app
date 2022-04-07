import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/questions/questions.dart';
import 'package:quiz_app/questions/question_api_response.dart';
import 'package:quiz_app/questions/question_for_listing.dart';
import 'package:quiz_app/questions/question_insert.dart';

class QuestionsService {
  static const API = 'https://word-quiz-app-backend.herokuapp.com';
  static const headers = {
    'Content-Type': 'application/json'
  };

  Future<QuestionAPIResponse<List<QuestionForListing>>> getQuestionsList() {
    return http.get(API + '/questions/all').then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final questions = <QuestionForListing>[];
        for (var item in jsonData) {
          questions.add(QuestionForListing.fromJson(item));
        }
        return QuestionAPIResponse<List<QuestionForListing>>(data: questions);
      }
      return QuestionAPIResponse<List<QuestionForListing>>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => QuestionAPIResponse<List<QuestionForListing>>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<QuestionAPIResponse<Questions>> getQuestion(String questionID) {
    return http.get(API + '/questions/'+questionID).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return QuestionAPIResponse<Questions>(data: Questions.fromJson(jsonData));
      }
      return QuestionAPIResponse<Questions>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => QuestionAPIResponse<Questions>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<QuestionAPIResponse<bool>> createQuestion(QuestionManipulation item) {
    return http.post(API + '/questions/MiyuruW/save', headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return QuestionAPIResponse<bool>(data: true);
      }
      return QuestionAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => QuestionAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<QuestionAPIResponse<bool>> updateQuestion(String questionID, QuestionManipulation item) {
    return http.put(API + '/questions/MiyuruW/'+questionID, headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 200) {
        return QuestionAPIResponse<bool>(data: true);
      }
      return QuestionAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => QuestionAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<QuestionAPIResponse<bool>> deleteQuestion(String questionID) {
    return http.delete(API + '/questions/'+questionID).then((data) {
      if (data.statusCode == 201) {
        return QuestionAPIResponse<bool>(data: true);
      }
      return QuestionAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => QuestionAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }
}
