import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app_ii_example/options/options.dart';
import 'package:quiz_app_ii_example/options/options_insert.dart';
import 'package:quiz_app_ii_example/services/options_service.dart';

class OptionsModify extends StatefulWidget {

  final String optionsID;
  OptionsModify({
    this.optionsID
  });

  @override
  _OptionsModifyState createState() => _OptionsModifyState();
}

class _OptionsModifyState extends State<OptionsModify> {
  bool get isEditing => widget.optionsID != null;

  OptionsService get service => GetIt.instance<OptionsService>();

  String errorMessage;
  Options options;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _questionController = TextEditingController();
  TextEditingController _correctController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      service.getOptions(widget.optionsID)
          .then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        options = response.data;
        _nameController.text = options.name;
        _codeController.text = options.code;
        _questionController.text = options.questionId;
        _correctController.text = options.isCorrect;
        _statusController.text = options.status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit option' : 'Create option')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: <Widget>[
            TextField(
              controller: _questionController,
              decoration: InputDecoration(hintText: 'Question'),
            ),
            Container(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            Container(height: 16),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(hintText: 'Code'),
            ),
            Container(height: 8),
            TextField(
              controller: _correctController,
              decoration: InputDecoration(hintText: 'Correct'),
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

                    final option = OptionsManipulation(
                        name: _nameController.text,
                        code: _codeController.text,
                        questionId: _questionController.text,
                        isCorrect: _correctController.text,
                        status: _statusController.text
                    );
                    final result = await service.updateOption(widget.optionsID, option);

                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your option was updated';

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

                    final option = OptionsManipulation(
                        name: _nameController.text,
                        code: _codeController.text,
                        questionId: _questionController.text,
                        isCorrect: _correctController.text,
                        status: _statusController.text
                    );
                    final result = await service.createOption(option);

                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your option was created';

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
