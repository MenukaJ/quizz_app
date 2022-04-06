import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app_ii_example/notes/note_api_response.dart';
import 'package:quiz_app_ii_example/notes/note.dart';
import 'package:quiz_app_ii_example/notes/note_for_listing.dart';
import 'package:quiz_app_ii_example/notes/note_insert.dart';

class NotesService {
  static const API = 'https://word-quiz-app-backend.herokuapp.com';
  static const headers = {
    'Content-Type': 'application/json'
  };

  Future<NoteAPIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/category/all').then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          notes.add(NoteForListing.fromJson(item));
        }
        return NoteAPIResponse<List<NoteForListing>>(data: notes);
      }
      return NoteAPIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => NoteAPIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<NoteAPIResponse<Note>> getNote(String noteID) {
    return http.get(API + '/category/'+noteID).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return NoteAPIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return NoteAPIResponse<Note>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => NoteAPIResponse<Note>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<NoteAPIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(API + '/category/MiyuruW/save', headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return NoteAPIResponse<bool>(data: true);
      }
      return NoteAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => NoteAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<NoteAPIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(API + '/category/MiyuruW/'+noteID, headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 200) {
        return NoteAPIResponse<bool>(data: true);
      }
      return NoteAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => NoteAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }

  Future<NoteAPIResponse<bool>> deleteNote(String noteID) {
    return http.delete(API + '/category/'+noteID).then((data) {
      if (data.statusCode == 201) {
        return NoteAPIResponse<bool>(data: true);
      }
      return NoteAPIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => NoteAPIResponse<bool>(error: true, errorMessage: 'An error occurred from API'));
  }
}
