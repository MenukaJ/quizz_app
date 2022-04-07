import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app_ii_example/questions/question_api_response.dart';
import 'package:quiz_app_ii_example/questions/question_delete.dart';
import 'package:quiz_app_ii_example/questions/question_for_listing.dart';
import 'package:quiz_app_ii_example/questions/question_modify.dart';
import 'package:quiz_app_ii_example/services/questions_service.dart';

class QuestionList extends StatefulWidget {

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  QuestionsService get service => GetIt.instance<QuestionsService>();

  QuestionAPIResponse<List<QuestionForListing>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchQuestions();
    super.initState();
  }

  _fetchQuestions() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getQuestionsList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of questions')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => QuestionModify()))
              .then((_) {
            _fetchQuestions();
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
                key: ValueKey(_apiResponse.data[index].questionID),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {

                },
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context,
                      builder: (_) => QuestionDelete()
                  );

                  if (result) {
                    final deleteResult = await service.deleteQuestion(_apiResponse.data[index].questionID);
                    var message;
                    if (deleteResult != null && deleteResult.data == true) {
                      message = 'The question was deleted successfully';
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
                  subtitle: Text('Question : ${_apiResponse.data[index].name}'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => QuestionModify(
                            questionID: _apiResponse.data[index].questionID))).then((data) {
                      _fetchQuestions();
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
