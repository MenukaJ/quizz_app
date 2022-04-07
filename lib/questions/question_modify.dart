import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app/questions/question_insert.dart';
import 'package:quiz_app/questions/questions.dart';

import '../services/questions_service.dart';

class QuestionModify extends StatefulWidget {

  final String questionID;
  QuestionModify({
    this.questionID
  });

  @override
  _QuestionModifyState createState() => _QuestionModifyState();
}

class _QuestionModifyState extends State<QuestionModify> {
  bool get isEditing => widget.questionID != null;

  QuestionsService get service => GetIt.instance<QuestionsService>();

  String errorMessage;
  Questions questions;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _solutionController = TextEditingController();
  TextEditingController _quizController = TextEditingController();
  TextEditingController _lockController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      service.getQuestion(widget.questionID)
          .then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        questions = response.data;
        _nameController.text = questions.name;
        _solutionController.text = questions.solution;
        _quizController.text = questions.quizId;
        _lockController.text = questions.isLocked;
        _statusController.text = questions.status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Question' : 'Create Question'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.purple],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: <Widget>[
            TextField(
              controller: _quizController,
              decoration: InputDecoration(hintText: 'Quiz'),
            ),
            Container(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            Container(height: 16),
            TextField(
              controller: _solutionController,
              decoration: InputDecoration(hintText: 'Solution'),
            ),
            Container(height: 8),
            TextField(
              controller: _lockController,
              decoration: InputDecoration(hintText: 'Locked'),
            ),
            Container(height: 8),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(hintText: 'Status'),
            ),
            Container(height: 8),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (isEditing) {
                    setState(() {
                      _isLoading = true;
                    });

                    final question = QuestionManipulation(
                        name: _nameController.text,
                        solution: _solutionController.text,
                        quizId: _quizController.text,
                        isLocked: _lockController.text,
                        status: _statusController.text
                    );
                    final result = await service.updateQuestion(widget.questionID, question);

                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your question was updated';

                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )
                    )
                        .then((data) {
                      if (result.data) {
                        Navigator.of(context).pop();
                      }
                    });
                  } else {
                    setState(() {
                      _isLoading = true;
                    });

                    final question = QuestionManipulation(
                        name: _nameController.text,
                        solution: _solutionController.text,
                        quizId: _quizController.text,
                        isLocked: _lockController.text,
                        status: _statusController.text
                    );
                    final result = await service.createQuestion(question);

                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your question was created';

                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )
                    )
                        .then((data) {
                      if (result.data) {
                        Navigator.of(context).pop();
                      }
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
