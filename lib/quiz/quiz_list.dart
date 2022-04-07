import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app_ii_example/quiz/quiz_api_response.dart';
import 'package:quiz_app_ii_example/quiz/quiz_delete.dart';
import 'package:quiz_app_ii_example/quiz/quiz_for_listing.dart';
import 'package:quiz_app_ii_example/quiz/quiz_modify.dart';
import 'package:quiz_app_ii_example/services/quiz_service.dart';


class QuizList extends StatefulWidget {

  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  QuizService get service => GetIt.instance<QuizService>();

  QuizAPIResponse<List<QuizForListing>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchQuizzes();
    super.initState();
  }

  _fetchQuizzes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getQuizList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of quizzes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => QuizModify()))
              .then((_) {
            _fetchQuizzes();
          });
        },
        child: Icon(Icons.add),
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return CircularProgressIndicator();
          }
          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }
          return ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].quizID),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {

                },
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context,
                      builder: (_) => QuizDelete()
                  );

                  if (result) {
                    final deleteResult = await service.deleteQuiz(_apiResponse.data[index].quizID);
                    var message;
                    if (deleteResult != null && deleteResult.data == true) {
                      message = 'The quiz was deleted successfully';
                    } else {
                      message = deleteResult?.errorMessage ?? 'An error occurred';
                    }

                    showDialog(
                        context: context, builder: (_) => AlertDialog(
                      title: Text('Done'),
                      content: Text(message),
                      actions: <Widget>[
                        FlatButton(child: Text('ok'), onPressed: () {
                          Navigator.of(context).pop();
                        })
                      ],
                    ));

                    return deleteResult?.data ?? false;
                  }

                  print(result);
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(child: Icon(Icons.delete, color: Colors.white), alignment: Alignment.centerLeft,),
                ),
                child : ListTile(
                  title: Text(
                    _apiResponse.data[index].quizName,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text('Subject : ${_apiResponse.data[index].categoryName}'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => QuizModify(
                            quizID: _apiResponse.data[index].quizID))).then((data) {
                      _fetchQuizzes();
                    });
                  },
                ),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        },
      ),
    );
  }
}
