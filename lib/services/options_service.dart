import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/options/options.dart';
import 'package:quiz_app/options/options_api_response.dart';
import 'package:quiz_app/options/options_for_listing.dart';
import 'package:quiz_app/options/options_insert.dart';

class OptionsService {
  static const API = 'https://word-quiz-app-backend.herokuapp.com';
  static const headers = {
    'Content-Type': 'application/json'
  };

  Future<OptionsAPIResponse<List<OptionsForListing>>> getOptionsList() {
    return http.get(API + '/options/all').then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final options = <OptionsForListing>[];
        for (var item in jsonData) {
          options.add(OptionsForListing.fromJson(item));
        }
        return OptionsAPIResponse<List<OptionsForListing>>(data: options);
      }
      return OptionsAPIResponse<List<OptionsForListing>>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => OptionsAPIResponse<List<OptionsForListing>>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<OptionsAPIResponse<Options>> getOptions(String optionsID) {
    return http.get(API + '/options/'+optionsID).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return OptionsAPIResponse<Options>(data: Options.fromJson(jsonData));
      }
      return OptionsAPIResponse<Options>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => OptionsAPIResponse<Options>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<OptionsAPIResponse<bool>> createOption(OptionsManipulation item) {
    return http.post(API + '/options/MiyuruW/save', headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return OptionsAPIResponse<bool>(data: true);
      }
      return OptionsAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => OptionsAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<OptionsAPIResponse<bool>> updateOption(String optionsID, OptionsManipulation item) {
    return http.put(API + '/options/MiyuruW/'+optionsID, headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 200) {
        return OptionsAPIResponse<bool>(data: true);
      }
      return OptionsAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => OptionsAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<OptionsAPIResponse<bool>> deleteOption(String optionsID) {
    return http.delete(API + '/options/'+optionsID).then((data) {
      if (data.statusCode == 201) {
        return OptionsAPIResponse<bool>(data: true);
      }
      return OptionsAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => OptionsAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }
}
