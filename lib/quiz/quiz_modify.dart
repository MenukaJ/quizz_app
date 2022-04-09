import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app/category/category_api_response.dart';
import 'package:quiz_app/category/category_for_listing.dart';
import 'package:quiz_app/quiz/quiz.dart';
import 'package:quiz_app/quiz/quiz_insert.dart';
import 'package:quiz_app/services/category_service.dart';
import '../services/quiz_service.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

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
  CategoryService get categoryService => GetIt.instance<CategoryService>();
  CategoryAPIResponse<List<CategoryForListing>> _categoryAPIResponse;

  String _myCategory;
  String _myStatus;
  String errorMessage;
  Quiz quiz;
  bool _isLoading = false;
  bool _isStatus = true;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _fetchCategories();
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
        _myCategory = quiz.categoryId;
        _myStatus = quiz.status;

        if (_myStatus == 'INACTIVE') {
          _isStatus = false;
        }
      });
    }
  }

  _fetchCategories() async {
    setState(() {
      _isLoading = true;
    });

    _categoryAPIResponse = await categoryService.getCategoryList();
    setState(() {
      _isLoading = false;
    });
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
            Container(
              margin: EdgeInsets.all(16),
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurpleAccent
              ),
              child : DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      dropdownColor: Colors.deepPurpleAccent,
                      value: _myCategory,
                      iconSize: 30,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      hint: Text('Select a Category', style: TextStyle(color: Colors.white)),
                      onChanged: (String newValue) {
                        setState(() {
                          _myCategory = newValue;
                          print(_myCategory);
                        });
                      },
                      items: _categoryAPIResponse.data?.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item.categoryName),
                          value: item.categoryID
                        );
                      })?.toList() ??
                          [],
                    ),
                  ),
                ),
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
            Container(height: 16),
            LiteRollingSwitch(
              value: _isStatus,
              textOn: "Active",
              textOff: "Inactive",
              colorOn: Colors.green,
              colorOff: Colors.redAccent,
              iconOn: Icons.done,
              iconOff: Icons.alarm_off,
              textSize: 16,
              onChanged: (bool position) {
                print('The button is $position');
                if (position) {
                  _myStatus = 'ACTIVE';
                } else {
                  _myStatus = 'INACTIVE';
                }
                print('Status is $_myStatus');
              },
            ),
            Container(height: 48),
            SizedBox(
              width: 200,
              height: 40,
              child: RaisedButton(
                child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)
                    ),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (isEditing) {
                    setState(() {
                      _isLoading = true;
                    });

                    final quiz = QuizManipulation(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        categoryId: _myCategory,
                        status: _myStatus
                    );
                    final result = await service.updateQuiz(widget.quizID, quiz);

                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Message';
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
                        categoryId: _myCategory,
                        status: _myStatus
                    );
                    final result = await service.createQuiz(quiz);

                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Message';
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