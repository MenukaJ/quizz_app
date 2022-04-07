import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app/quiz/quiz.dart';
import 'package:quiz_app/quiz/quiz_insert.dart';
import '../services/quiz_service.dart';

class QuizModify extends StatefulWidget {

  final String quizID;
  QuizModify({
    this.quizID
  });

  @override
  _QuizModifyState createState() => _QuizModifyState();
}

class _QuizModifyState extends State<QuizModify> {
  bool get isEditing => widget.quizID != null;

  QuizService get service => GetIt.instance<QuizService>();

  String errorMessage;
  Quiz quiz;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      service.getQuiz(widget.quizID)
          .then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        quiz = response.data;
        _nameController.text = quiz.name;
        _descriptionController.text = quiz.description;
        _categoryController.text = quiz.categoryId;
        _statusController.text = quiz.status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Quiz' : 'Create Quiz'),
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
              controller: _categoryController,
              decoration: InputDecoration(hintText: 'Category'),
            ),
            Container(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            Container(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Description'),
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

                    final quiz = QuizManipulation(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        categoryId: _categoryController.text,
                        status: _statusController.text
                    );
                    final result = await service.updateQuiz(widget.quizID, quiz);

                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your quiz was updated';

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

                    final quiz = QuizManipulation(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        categoryId: _categoryController.text,
                        status: _statusController.text
                    );
                    final result = await service.createQuiz(quiz);

                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your quiz was created';

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